require './config/environment.rb'

class Zip
  include Mongoid::Document

  field :code, type: String
  embeds_many :streets
  embedded_in :borough

  index({code: 1}, {unique: true})

end