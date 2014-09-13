require './config/environment.rb'

task :seed_brooklyn do

  tree_names = JSON.parse(File.read("./tree_dict.rb"))
  brooklyn = Borough.create(name: "Brooklyn")
  CSV.parse(File.read('BrooklynTree.csv')) do |row|
    species_code  = row[13]
    building_num  = row[6]
    street_name   = Street.normalize_name(row[7])
    zip           = row[-3]
    species_name  = tree_names[species_code]
    if street = brooklyn.streets.find_by(name: street_name)
      street.trees.create(building_num: building_num, zip: zip, species: species_name)
    else
      puts "created #{street_name}"
      brooklyn.streets.create(name: street_name).trees.create(building_num: building_num, zip: zip, species: species_name)
    end
  end
  File.delete('BrooklynTree.csv')
end

task :seed_manhattan do
  tree_names = JSON.parse(File.read("./tree_dict.rb"))
  manhattan = Borough.create(name: "Manhattan")
  CSV.parse(File.read('ManhattanTree.csv')) do |row|
    species_code  = row[13]
    building_num  = row[6]
    street_name   = Street.normalize_name(row[7])
    zip           = row[-3]
    species_name  = tree_names[species_code]
    if street = manhattan.streets.find_by(name: street_name)
      street.trees.create(building_num: building_num, zip: zip, species: species_name)
    else
      puts "created #{street_name}"
      manhattan.streets.create(name: street_name).trees.create(building_num: building_num, zip: zip, species: species_name)
    end
  end
  File.delete('ManhattanTree.csv')
end

task :seed_images do
  Image.create(species: "LONDON PLANETREE", image: "http://upload.wikimedia.org/wikipedia/commons/b/b0/London_Planetree_bark_detail.jpg")
  Image.create(species: "LITTLE LEAF LINDEN", image: "http://plants.usda.gov/gallery/pubs/tico2_002_php.jpg")
  Image.create(species: "CALLERY PEAR", image: "http://upload.wikimedia.org/wikipedia/commons/a/a0/Pyrus_calleryana_fruits_and_leaf.JPG")
  Image.create(species: "NORWAY MAPLE", image: "http://upload.wikimedia.org/wikipedia/commons/b/bc/Acer_platanoides_1aJPG.jpg")
  Image.create(species: "JAPANESE ZELKOVA", image: "http://upload.wikimedia.org/wikipedia/commons/b/bb/Zelkova_serrata5.jpg")
  Image.create(species: "HONEYLOCUST", image: "http://plants.usda.gov/gallery/pubs/gltr_003_php.jpg")
  Image.create(species: "PIN OAK", image: "http://upload.wikimedia.org/wikipedia/commons/c/c4/Hampstead_Heath_07_Pin_Oak_%284152247041%29.jpg")
  Image.create(species: "SWEETGUM", image: "tree_2.jpg")
end