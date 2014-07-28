require 'sinatra/base'

class BookMark < Sinatra::Base
  get '/' do
    'Hello BookMark!'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
