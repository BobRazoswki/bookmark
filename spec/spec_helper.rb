ENV["RACK_ENV"] = 'test'

#require File.join(File.dirname(__FILE__), '..', 'app/server.rb')
require './app/server'
#require 'server'
require 'database_cleaner'
require 'capybara/rspec'
require 'sinatra'


Capybara.app = Chitter

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  
  
end