ENV["RACK_ENV"] = 'test'
require './app/server'
require 'database_cleaner'
require 'capybara/rspec'
require 'sinatra'

Capybara.app = BookMark.new

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