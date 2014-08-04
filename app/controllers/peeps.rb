class Chitter < Sinatra::Base

get '/peeps/new' do
	erb :'peeps/new'
end

post '/peeps' do
	if current_user
	peep = Peep.new(message: params[:message], timestamp: Time.now, user_id: current_user.id)
  peep.save
  redirect to '/' 
else
	redirect to '/users/new'
end
end



end

	