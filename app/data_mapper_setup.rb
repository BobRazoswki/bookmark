env = ENV["RACK_ENV"] || "development"

require_relative 'models/peep' 
require_relative 'models/user'
require_relative 'models/reply'

DataMapper.setup(:default, ENV['DATABASE_URL']  || "postgres://localhost/chitter_#{env}")
DataMapper.finalize
