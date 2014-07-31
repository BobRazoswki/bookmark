require 'bcrypt'
require 'rest_client'

class User

	include DataMapper::Resource

	property :id, Serial
	property :email, String, :unique => true, :message => "This email is already taken"
	property :password_digest, Text
	#create a token, set a time duration
	property :password_token, Text, :unique => true
	property :password_token_timestamp, Time

	def password=(password)
		@password = password
		self.password_digest = BCrypt::Password.create(password)
	end

	attr_reader :password
	attr_accessor :password_confirmation

	validates_confirmation_of :password
	validates_uniqueness_of :email

	def self.authenticate(email, password)
		user = first(:email => email)

		if user && BCrypt::Password.new(user.password_digest) == password
			user
		else
			nil
		end

	end

=begin
	def self.generate_token(email)
		user = first(:email => email)
		user.password_token = (1..64).map{('A'..'Z').to_a.sample}.join
		user.password_token_timestamp = Time.now
		user.save
	end
=end


	def self.change_password(email,new_password)
		user = first(:email => email)
		if user
			user.update!(password: new_password, password_digest: BCrypt::Password.create(new_password) )
		end
	end

def send_simple_message(email, password_token)
  RestClient.post "https://api:key-1233ceff8ae2c3122bbe2142ea629427"\
    "@api.mailgun.net/v2/sandbox27040c50b6e045f7a7ac475b51b9ac43.mailgun.org/messages",
  :from => "Mailgun Sandbox <postmaster@sandbox27040c50b6e045f7a7ac475b51b9ac43.mailgun.org>",
  :to => email,
  :subject => "Hello",
  :text => "click and reset your password, AND DON'T FORTGET IT AGAIN http://intense-everglades-2463.herokuapp.com/users/reset_password/#{password_token} "
end


end