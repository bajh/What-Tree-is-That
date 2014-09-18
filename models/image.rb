require './config/environment.rb'

class Image
  include Mongoid::Document

  field :species, type: String
  field :image, type: String

end