require './config/environment.rb'

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