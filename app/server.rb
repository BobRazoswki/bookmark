require 'data_mapper'
require 'sinatra'
require 'sinatra/flash'
require 'sinatra/partial'
require_relative 'helpers/application'
require_relative 'data_mapper_setup'
require_relative 'controllers/users'
require_relative 'controllers/links'
require_relative 'controllers/tags'
require_relative 'controllers/application'
require_relative 'controllers/sessions'
require_relative 'controllers/forgot_password'

class BookMark < Sinatra::Base
	use Rack::MethodOverride
	include ApplicationHelper
	
	set :views, Proc.new { File.join(root, "..", "views") }
	set :public_folder, Proc.new { File.join(root, "..", "public") }

	enable :sessions
	set :sessions_secret, 'bob super secret'

  register Sinatra::Flash
	set :partial_template_engine, :erb

  # start the server if ruby file executed directly
  run! if app_file == $0

end
