env = ENV["RACK_ENV"] || "development"
#DataMapper::Logger.new(STDOUT, :debug)
require_relative 'models/peep' # this needs to be done after datamapper is initialised
require_relative 'models/user'

DataMapper.setup(:default, "postgres://localhost/chitter_#{env}")
DataMapper.finalize
 