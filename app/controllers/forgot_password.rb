class BookMark < Sinatra::Base

	post '/forgot_password' do
	#get the email adress and check if we have it in the record
	@user = User.first(:email => params[:email])

		if @user
			flash[:notice] = "email sent"
			redirect to('/password_sent')
		else
			flash[:notice] = "wrong email bob"
			redirect to('/users/reset_password')
		end

	end

	get '/forgot_password' do
	"bo"
	end

	get '/password_sent' do
		"need to figure out how to send a fucking token now"
	end

	get '/users/reset_password' do
		erb :"users/reset_password"
	end

	get '/users/reset_password/:token' do

		@user = User.first(:password_token => params["token"])
		if @user
    	erb :'/users/new_password'
    else
    	erb :token_invalid
    end

  end

  post '/users/reset_password/:token' do
  	#then connect those info to the db
  	#generate a new digest
  	#migrate it into the db

  	#password, confirmation = params[:password], params[:confirmation]
  	#user = User.authenticate(password, confirmation)
#need to check if the token is the right one

=begin
	user = User.authenticate(password_token, password_token_timestamp)

  	if user
				session[:user_id] = user.id
				redirect to('/users/reset_password/:token')
		else
				flash[:errors] = ["The token is incorrect"]
				erb :"sessions/new"
		end
=end

  	
  end

end