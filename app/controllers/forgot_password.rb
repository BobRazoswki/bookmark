class BookMark < Sinatra::Base

	post '/forgot_password' do
	#get the email adress and check if we have it in the record
		user = User.first(:email => params[:email]) && User.generate_token(params[:email])
		if user
			user.send_simple_message(email)
		else
			flash[:notice] = "wrong email bob"
			redirect to('/users/reset_password')
		end

	end

	get '/forgot_password' do
	"bob"
	end

	get '/password_sent' do
		"need to figure out how to send a fucking token now"
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