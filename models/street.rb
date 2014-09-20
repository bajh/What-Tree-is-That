require './config/environment.rb'

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
      return nil if trees_on_street_side.empty?
      species = trees_on_street_side.map{ |tree| [(tree.normalized_building_num - user_building_num.to_i).abs, tree] }.min[1]
      if (species.building_num.to_i - user_building_num.to_i).abs > 10
        species = Tree.new(species: "UNKNOWN", building_num: user_building_num)
      end
    else 
      trees_on_street_side = user_building_num.to_i.odd? ? self.manhattantrees.select{ |tree| tree.normalized_building_num.odd?} : self.manhattantrees.select{ |tree| tree.normalized_building_num.even?}
      return nil if trees_on_street_side.empty?
      species = trees_on_street_side.map{ |tree| [(tree.normalized_building_num - user_building_num.to_i).abs, tree] }.min[1]
    end
    return species
  end

end