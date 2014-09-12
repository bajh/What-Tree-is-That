require './config/environment.rb'

class Tree
  include Mongoid::Document
  include Geocoder::Model::Mongoid
  geocoded_by :address
  after_validation :geocode

  field :coordinates, type: Array
  field :address, type: String
  field :species, type: String

  create_indexes

end

class Street
  include Mongoid::Document

  field :name, type: String
  embeds_many :brooklyntrees

  def nearest_tree_to(user_building_num)
    building_nums = self.brooklyntrees.map{ |tree| tree.building_num }
    return (building_nums)
  end

end

class Brooklyntree
  include Mongoid::Document

  field :building_num, type: String
  field :zip, type: String
  field :species, type: String
  embedded_in :street

end