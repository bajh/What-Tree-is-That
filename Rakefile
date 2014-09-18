require './config/environment.rb'

task :seed_brooklyn do
  if borough = Borough.find_by(name: "Brooklyn")
    borough.delete
    Tree.all.delete
    Street.all.delete
    puts Borough.count
    puts Tree.count
    puts Street.count
  end
  brooklyn = Borough.create(name: "Brooklyn")
  tree_names = JSON.parse(File.read("./tree_dict.rb"))
  CSV.parse(File.read('BrooklynTree.csv')) do |row|
    species_code  = row[13]
    building_num  = row[6]
    street_name   = Street.normalize_name(row[7])
    zip_code      = row[-3]
    species_name  = tree_names[species_code]
    brooklyn = Borough.find_by(name: "Brooklyn")
    zip = brooklyn.zips.find_or_create_by(code: zip_code)
    street = zip.streets.find_or_create_by(name: street_name)
    tree = street.trees.build(building_num: building_num, species: species_name)
    street.save
    tree.save
  end
end

task :seed_manhattan do
  if borough = Borough.find_by(name: "Manhattan")
    borough.delete
  end
  manhattan = Borough.create(name: "Manhattan")
  tree_names = JSON.parse(File.read("./tree_dict.rb"))
  x = 0
  CSV.parse(File.read('ManhattanTree.csv')) do |row|
    species_code  = row[13]
    building_num  = row[6]
    street_name   = Street.normalize_name(row[7])
    zip_code      = row[-3]
    species_name  = tree_names[species_code]
    manhattan = Borough.find_by(name: "Manhattan")
    zip = manhattan.zips.find_or_create_by(code: zip_code)
    street = zip.streets.find_or_create_by(name: street_name)
    tree = street.manhattantrees.build(building_num: building_num, species: species_name)
    street.save
    tree.save
    x += 1
    puts x
  end
end

task :seed_images do
  Image.all.delete
  tree_names = JSON.parse(File.read("./tree_dict.rb"))
  tree_names.each do |abb, long|
    image = ImageScraper.new(long).find_image
    Image.create(species: long, image: image)
    puts "#{long}: #{image}"
  end
  Image.find_by(species: "NORWAY-CRIMSON KING MAPLE").update_attribute(:image, "http://upload.wikimedia.org/wikipedia/commons/f/fb/A_pl_CrimsonKing1.JPG")
  Image.find_by(species: "HORSECHESTNUT").update_attribute(:image, "http://plants.usda.gov/gallery/pubs/aehi_006_php.jpg")
  Image.find_by(species: "ATLAS CEDAR").update_attribute(:image, "http://upload.wikimedia.org/wikipedia/commons/9/90/Atlas_Cedar_Cedrus_atlantica_%27Glauca%27_Needles_3008px.JPG")
  Image.find_by(species: "KATSURA TREE").update_attribute(:image, "http://upload.wikimedia.org/wikipedia/commons/8/86/Cercidiphyllum_japonicum_001.jpg")
  Image.find_by(species: "FRINGE TREE").update_attribute(:image, "http://upload.wikimedia.org/wikipedia/commons/c/c0/Chionanthus_virginicus_a2.jpg")
  Image.find_by(species: "GINGKO").update_attribute(:image, "http://upload.wikimedia.org/wikipedia/commons/3/30/Feuilles_de_Gingko_Biloba.jpg")
  Image.find_by(species: "WITCH HAZEL").update_attribute(:image, "http://upload.wikimedia.org/wikipedia/commons/b/be/Hamamelis_virginiana_02.JPG")
  Image.find_by(species: "SAWTOOTH OAK").update_attribute(:image, "http://upload.wikimedia.org/wikipedia/commons/6/65/Quercus_acutissima_leaves_02_by_Line1.JPG")
end