env = ENV["RACK_ENV"] || "development"

require_relative 'models/link' # this needs to be done after datamapper is initialised
require_relative 'models/tag'
require_relative 'models/user'

DataMapper.setup(:default, "postgres://localhost/bookmark_manager_#{env}")
DataMapper.finalize