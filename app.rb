require './environment.rb'
require './tree.rb'

tree_names = JSON.parse(File.read("./tree_dict1.rb"))

### This block of code was used to convert a list of tree name abbreviations to the full tree names ###
# write_file = File.open("./tree_dict1.rb", "w")
# tree_data = {}
# File.open("./tree_dict.rb") do |read_file|
#   read_file.each_line do |line|
#     if line.include? ','
#       abb_and_second_part, first_part = line.split(", ")
#       abb, second_part = abb_and_second_part.split(" ")
#       tree_data[abb] = first_part.chomp + " " + second_part.chomp
#     else
#       abb = line.split(" ")[0]
#       tree_name = line.split(" ")[1..-1].join(" ")
#       tree_data[abb] = tree_name.chomp
#     end
#   end
#   tree_data_json = JSON.dump(tree_data, write_file)
# end
# write_file.close

lines_left = 51_662 - Tree.count
csv_file = `tail -n #{lines_left} ManhattanTree.csv`

CSV.parse(csv_file) do |row|
  tree_species = row[13]
  address = row[6] + " " + row[7] + ", New York, NY " + row[-3]
  coords = Geocoder.coordinates(address)
  Tree.create(address: address, species: tree_names[tree_species])
  sleep 0.2
end

#Tree.near([whatever the user's coordinates are], 1)