require './config/environment.rb'

class ApplicationController < Sinatra::Base

  get '/' do
    send_file File.join('public', 'index.html')
  end

  post '/coordinates' do
    begin
      user = User.new(params)
    rescue
      content_type :json
      {species: "error", image: nil, debug: nil}.to_json
    end
    borough = Borough.find_by(name: user.borough)
    zip_code = borough.zips.find_by(code: user.zip_code)
    if street = zip_code.streets.where(name: user.street).first
      tree_object = street.nearest_tree_to(user.building_num)
      tree_species = tree_object.species
      image = Image.find_by(species: tree_species)
      content_type :json
      {species: tree_species, image: image, debug: user.building_num + user.street}.to_json
    else
      content_type :json
      {species: nil, image: nil, debug: nil}.to_json
    end
  end

end