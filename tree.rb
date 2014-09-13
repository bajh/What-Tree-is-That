require './config/environment.rb'

# class Borough
#   include Mongoid::Document

#   field :name, type: String
#   embeds_many :streets

# end

class Street
  include Mongoid::Document

  field :name, type: String
  embeds_many :brooklyntrees

    def nearest_tree_to(user_building_num)
      trees_on_street = self.brooklyntrees
      trees_on_street_side = user_building_num.to_i.odd? ? trees_on_street.select{ |tree| tree.odd?} : trees_on_street.select{ |tree| tree.even?}
      species = trees_on_street_side.map{ |tree| [(tree.building_num.to_f - user_building_num.to_f).abs, tree] }.min[1]
      return species
    end

end

class Brooklyntree
  include Mongoid::Document

  field :building_num, type: String
  field :zip, type: String
  field :species, type: String
  field :image, type: String
  embedded_in :street

end

class Image
  include Mongoid::Document

  field :species, type: String
  field :image, type: String

end