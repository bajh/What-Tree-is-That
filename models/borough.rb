require './config/environment.rb'

class Borough
  include Mongoid::Document

  field :name, type: String
  embeds_many :zips

end
