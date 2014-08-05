class Chitter < Sinatra::Base

	get '/' do
		@peeps = Peep.all(:order => [ :timestamp.desc ])
		@replies = Reply.all(:order => [ :timestamp.desc ])
	  erb :index
	end


end