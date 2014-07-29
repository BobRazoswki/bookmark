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

end