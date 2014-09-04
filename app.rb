class ApplicationController < Sinatra::Base

  get '/' do
    send_file File.join('public', 'index.html')
  end

  post '/coordinates' do
    tree_names = JSON.parse(File.read("./tree_dict1.rb"))
    if nearest_tree = Tree.near([params["latitude"], params["longitude"]], 1).first
      species = nearest_tree.species
      content_type :json
      { :species => species, :image => 'http://www.nps.gov/plants/alien/pubs/midatlantic/img/pyca-BJ.jpg' }.to_json
    else 
      content_type :json
      { :species => nil, :image => nil }.to_json
    end
  end

end