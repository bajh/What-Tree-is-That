ENV['RACK_ENV'] ||= 'development'


require 'bundler'
Bundler.require(:default)

require 'csv'
require 'json'

configure do
  Mongoid.load!('./mongoid.yml')
end

Geocoder::Configuration.always_raise << Geocoder::OverQueryLimitError
Geocoder::Configuration.timeout = 15

require './tree.rb'
require './app.rb'