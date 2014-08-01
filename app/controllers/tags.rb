class BookMark < Sinatra::Base
	
	get '/tags/:text' do
		tag = Tag.first(:text => params[:text])
		@links = tag ? tag.links : []
		erb :index
	end
	
	post '/tags/:text' do
		
	end

end