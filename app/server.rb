require 'data_mapper'
require 'sinatra'
require 'sinatra/flash'
require_relative 'helpers/application'
require_relative 'data_mapper_setup'
require_relative 'controllers/users'
require_relative 'controllers/links'
require_relative 'controllers/tags'
require_relative 'controllers/application'

class BookMark < Sinatra::Base
	include ApplicationHelper
	
	set :views, Proc.new { File.join(root, "..", "views") }

	enable :sessions
	set :sessions_secret, 'bob super secret'
   register Sinatra::Flash


  # start the server if ruby file executed directly
  run! if app_file == $0
end
