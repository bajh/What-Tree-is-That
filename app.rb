require './config/environment.rb'
require './user.rb'

class ApplicationController < Sinatra::Base

  get '/' do
    puts Tree.count
    send_file File.join('public', 'index.html')
  end

  post '/coordinates' do
    user = User.new(params)
    content_type :json
    {species: user.borough, image: nil, debug: nil}
    borough = Borough.find_by(name: user.borough)
    if street = borough.streets.where(name: user.street).first
      tree_object = street.nearest_tree_to(user.building_num)
      tree_species = tree_object.species
      unless image = Image.find_by(species: tree_species)
        puts "getting image from website"
        image = ImageScraper.new(tree_species).find_image
        Image.create(species: tree_species, image: image)
      end
      content_type :json
      {species: tree_species, image: image, debug: user.building_num + user.street}.to_json
    else
      content_type :json
      {species: nil, image: nil, debug: nil}
    end
  end

end