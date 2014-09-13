require './config/environment.rb'

task :seed_brooklyn do

  tree_names = JSON.parse(File.read("./tree_dict.rb"))
  CSV.parse(File.read('BrooklynTree.csv')) do |row|
    species_code  = row[13]
    building_num  = row[6]
    street_name   = row[7]
    zip           = row[-3]
    species_name  = tree_names[species_code]
    if street = Street.find_by(name: street_name)
      street.brooklyntrees.create(building_num: building_num, zip: zip, species: species_name)
    else
      Street.create(name: street_name).brooklyntrees.create(building_num: building_num, zip: zip, species: species_name)
    end
  end

  task :seed_manhattan do
    tree_names = JSON.parse(File.read("./tree_dict.rb"))
    CSV.parse(File.read('ManhattanTree.csv')) do |row|
      species_code  = row[13]
      building_num  = row[6]
      street_name   = row[7]
      zip           = row[-3]
      species_name  = tree_names[species_code]
      if street = Street.find_by(name: street_name)
        street.brooklyntrees.create(building_num: building_num, zip: zip, species: species_name)
      else
        Street.create(name: street_name).brooklyntrees.create(building_num: building_num, zip: zip, species: species_name)
      end
  end

end