class Chitter < Sinatra::Base

	get '/replies/new' do
		erb :'replies/new'
	end

	post '/replies/:peep_id/:user_id' do |peep_id, user_id|
reply = Reply.new(message: params[:message], timestamp: Time.now, user_id: user_id, peep_id: peep_id)
		if peep_id != nil 
			reply.save
			redirect to '/' 
		else 
			redirect to 'users/new'
		end
	end

end
