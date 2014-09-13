require './config/environment.rb'

class ApplicationController < Sinatra::Base

  get '/' do
    binding.pry
    send_file File.join('public', 'index.html')
  end

  post '/coordinates' do
    coords = params["latitude"] + ", " + params["longitude"]
    geo_object = Geocoder.search(coords)
    user_borough = geo_object.first.address_components[3]["long_name"]
    user_building_num = geo_object.first.address_components[0]["long_name"]
    user_street = geo_object.first.address_components[1]["long_name"].upcase
    street = Street.where(name: user_street).first
    tree_object = street.nearest_tree_to(user_building_num)
    tree_species = tree_object.species
    unless image = Image.find_by(species: tree_species)
      puts "getting image from website"
      image = ImageScraper.new(tree_species).find_image
      Image.create(species: tree_species, image: image)
    end
    content_type :json
    {species: tree_species, image: image, debug: user_building_num + user_street}.to_json
  end

end