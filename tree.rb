require './config/environment.rb'

class Borough
  include Mongoid::Document

  field :name, type: String
  embeds_many :streets

end

class Street
  include Mongoid::Document

  field :name, type: String
  embedded_in :borough
  embeds_many :trees

  def normalize_name(street_name)
    street_name.gsub(/\s+/, ' ').upcase
  end

  def nearest_tree_to(user_building_num)
    trees_on_street_side = user_building_num.to_i.odd? ? self.trees.select{ |tree| tree.normalized_building_num.odd?} : self.trees.select{ |tree| tree.normalized_building_num.even?}
    species = trees_on_street_side.map{ |tree| [(tree.normalized_building_num - user_building_num.to_i).abs, tree] }.min[1]
    return species
  end

end

class Tree
  include Mongoid::Document

  field :building_num, type: String
  field :zip, type: String
  field :species, type: String
  field :image, type: String
  embedded_in :street

  #Some addresses have a dash in them, which might mess up the nearest_tree function. This removes it
  def normalized_building_num
    self.building_num.split("-")[0].to_i
  end

end

class Image
  include Mongoid::Document

  field :species, type: String
  field :image, type: String

end