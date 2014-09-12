require './config/environment.rb'

CSV.parse(csv_file) do |row|
  begin
  tree_species = row[13]
  address = row[6] + " " + row[7] + ", New York, NY " + row[-3]
  coords = Geocoder.coordinates(address)
  Tree.create(address: address, species: tree_names[tree_species])
  sleep 0.4
  rescue
    puts "Exception raised with #{51_662 - Tree.count} lines left to process"
    raise
  end
end
