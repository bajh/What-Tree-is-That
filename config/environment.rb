ENV['RACK_ENV'] ||= 'development'


require 'bundler'
Bundler.require(:default)

require 'csv'
require 'json'
require 'open-uri'

configure do
  Mongoid.load!('./mongoid.yml')
end

Geocoder::Configuration.always_raise << Geocoder::OverQueryLimitError
Geocoder::Configuration.timeout = 15

require './app.rb'
require './lib/image_scraper.rb'

Dir[File.join(File.dirname(__FILE__), "../models", "*.rb")].each { |f| require f }