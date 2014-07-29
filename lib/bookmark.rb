require 'data_mapper'
require 'sinatra'
require 'rack-flash'
env = ENV["RACK_ENV"] || "development"


DataMapper.setup(:default, "postgres://localhost/bookmark_manager_#{env}") #, "dbtype://user:password@hostname:port/databasename"

require './lib/link' # this needs to be done after datamapper is initialised
require './lib/tag'
require './lib/user'
require_relative '../helpers/application'

DataMapper.finalize
DataMapper.auto_upgrade!

class BookMark < Sinatra::Base

	include ApplicationHelper
	
	set :views, Proc.new { File.join(root, "..", "views") }

	enable :sessions
	set :sessions_secret, 'bob super secret'

	use Rack::Flash

  get '/' do
  	@links = Link.all
    erb :index
  end

  post '/links' do
  	url = params[:url]
  	title = params[:title]
  	tags = params[:tags].split(" ").map do |tag|
  		Tag.first_or_create(:text => tag)
  	end
  	Link.create(:url => url, :title => title, :tags => tags)
  	redirect to('/')
  end

  get '/tags/:text' do
  	tag = Tag.first(:text => params[:text])
  	@links = tag ? tag.links : []
  	erb :index
  end

  get '/users/new' do
  	@user = User.new
  	erb :"users/new"
  end

  post '/users' do
  		@user = User.create(:email => params[:email],
  		:password => params[:password],
  		:password_confirmation => params[:password_confirmation])
  	if @user.save 
			session[:user_id] = @user.id
			redirect to('/')
  	else
  		flash[:notice] = "Sorry, your passwords don't match"
  		erb :"users/new"
  	end
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
