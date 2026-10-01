require 'rubygems'
require 'bundler/setup'
require 'logger'
require 'mongoid'
require 'rspec'
require 'mongoid-random'
require 'database_cleaner/mongoid'

Mongoid.configure do |config|
  config.connect_to("mongoid_random_test")
end
Mongoid.logger.level = Logger::ERROR
Mongo::Logger.logger.level = Logger::ERROR

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

DatabaseCleaner[:mongoid].strategy = [:deletion]

RSpec.configure do |c|
  # RSpec 3 with the RSpec 2-era `should` syntax still enabled, so the existing specs run unchanged.
  c.expect_with(:rspec) { |e| e.syntax = [:should, :expect] }
  c.mock_with(:rspec) { |m| m.syntax = [:should, :expect] }
  c.before(:each) { DatabaseCleaner.clean }
end
