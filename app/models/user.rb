require 'bcrypt'
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

	def self.generate_token(email)
		user = first(:email => email)
		user.password_token = (1..64).map{('A'..'Z').to_a.sample}.join
		user.password_token_timestamp = Time.now
		user.save
	end

end