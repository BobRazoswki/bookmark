class Chitter < Sinatra::Base

	post '/forgot_password' do
		user = User.first(:email => params[:email]) 
		if user
			user.password_token = (1..64).map{('A'..'Z').to_a.sample}.join
			user.password_token_timestamp = Time.now
			user.save
			user.send_simple_message(params[:email], user.password_token)
			flash[:notice] = "email sent"
			redirect to('/password_sent')
		else
			flash[:notice] = "wrong email"
			redirect to('/users/reset_password')
		end
	end

	get '/password_sent' do
    erb :"users/password_sent"
  end


	get '/users/reset_password' do
		erb :"users/reset_password"
	end

	get '/users/reset_password/:token' do
		@user = User.first(:password_token => params["token"]) 
		if @user && @user.password_token_timestamp > (Time.now - 3600)
			@password_token = params[:token]
    	erb :'/users/new_password'
    else
    	erb :token_invalid
    end
  end

  post '/users/forgot_password/:token' do
  		user = User.first(:password_token => params[:token])
      password, confirmation = params[:password], params[:confirmation]
  	if password == confirmation
  		User.change_password(user.email, password)
  		erb :"users/password_changed"
  	else
  		('/')
  	end
  end

  post '/users/reset_password/:token' do
  	erb :"users/new_password"
  end

end