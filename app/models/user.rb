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

	def self.change_password(email,new_password)
		user = first(:email => email)
		if user
			user.update!(password: new_password, password_digest: BCrypt::Password.create(new_password) )
		end
	end

def send_simple_message
  RestClient.post "https://api:key-a5e44eb333d6b56a0383f46d6e3ee5ec"\
  "@api.mailgun.net/v2/samples.mailgun.org/messages",
  :from => "postmaster@sandbox08b134a3e23b413ba3066934890a03fd.mailgun.org",
  :to => "bobongithub@gmail.com",
  :subject => "Hello",
  :text => "Testing some Mailgun awesomness! "
end

end