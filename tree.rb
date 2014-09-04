require './environment.rb'

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