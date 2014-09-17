require './config/environment.rb'

class Borough
  include Mongoid::Document

  field :name, type: String
  embeds_many :zips

end

class Zip
  include Mongoid::Document

  field :code, type: String
  embeds_many :streets
  embedded_in :borough

  index({code: 1}, {unique: true})

end

class Street
  include Mongoid::Document

  field :name, type: String
  embedded_in :zip
  has_many :trees
  has_many :manhattantrees

  index({name: 1}, {unique: true})

  def self.normalize_name(street_name)
    street_name.gsub(/\s+/, ' ').upcase
  end

  def nearest_tree_to(user_building_num)
    if self.zip.borough.name == "Brooklyn"
      trees_on_street_side = user_building_num.to_i.odd? ? self.trees.select{ |tree| tree.normalized_building_num.odd?} : self.trees.select{ |tree| tree.normalized_building_num.even?}
      species = trees_on_street_side.map{ |tree| [(tree.normalized_building_num - user_building_num.to_i).abs, tree] }.min[1]
    else 
      trees_on_street_side = user_building_num.to_i.odd? ? self.manhattantrees.select{ |tree| tree.normalized_building_num.odd?} : self.manhattantrees.select{ |tree| tree.normalized_building_num.even?}
      species = trees_on_street_side.map{ |tree| [(tree.normalized_building_num - user_building_num.to_i).abs, tree] }.min[1]
    end
    return species
  end

end

class Tree
  include Mongoid::Document

  field :building_num, type: String
  field :species, type: String
  belongs_to :street, index: true

  index({building_num: 1}, {unique: true})

  #Some addresses have a dash in them, which might mess up the nearest_tree function. This removes it
  def normalized_building_num
    self.building_num.split("-")[0].to_i
  end

end


# I was concerned about the tree document becoming too long so I split it up into two separate documents, one for Manhattan trees
class Manhattantree
  include Mongoid::Document

  field :building_num, type: String
  field :species, type: String
  belongs_to :street, index: true

  index({building_num: 1}, {unique: true})

  def normalized_building_num
    self.building_num.split("-")[0].to_i
  end

end

class Image
  include Mongoid::Document

  field :species, type: String
  field :image, type: String

end