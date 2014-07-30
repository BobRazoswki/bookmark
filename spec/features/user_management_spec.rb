require 'spec_helper'
require_relative '../helpers/session'

include SessionHelpers

feature "Users sign up" do

	scenario "when being logged out" do
		expect{ sign_up }.to change(User, :count).by(1)
		# save_and_open_page
		expect(page).to have_content ("Welcome, alice@example.com")
		expect(User.first.email).to eq("alice@example.com")
	end

	scenario "with a password that doesn't match" do
		expect{ sign_up("a@a.com", "pass", "wrong") }.to change(User, :count).by(0)
		# lambda { sign_up('a@a.com', 'pass', 'wrong') }.should change(User, :count).by(0) 
		expect(current_path).to eq('/users')   
    expect(page).to have_content("Sorry, there were the following problems with the form. Password does not match the confirmation Please sign up Email: Password: Password confirmation:") 
	end

	scenario "with and email that is already resgistered" do
		expect{ sign_up }.to change(User, :count).by(1)
		expect{ sign_up }.to change(User, :count).by(0)
		expect(page).to have_content("This email is already taken")
	end

end

feature "User signs in" do
	
	before(:each) do
		User.create(:email => "test@test.com",
								:password => "test",
								:password_confirmation => "test")
	end

	scenario "with correct credentials" do
		visit('/')
		expect(page).not_to have_content("Welcome, test@test.com")
		sign_in('test@test.com', 'test')
		expect(page).to have_content("Welcome, test@test.com")
	end

	scenario "with incorrect credentials" do
		visit('/')
		expect(page).not_to have_content("Welcome, test@test.com")
		sign_in('test@test.com', 'bob')
		expect(page).not_to have_content("Welcome, test@test.com")
	end

end

feature 'Users sign out' do
	
	before(:each) do
		User.create(:email => 'test@test.com',
			:password => 'test',
			:password_confirmation => 'test')
	end

	scenario "while being sign in" do
		sign_in('test@test.com', 'test')
		click_button "Sign out"
		expect(page).to have_content('Good bye!')
		expect(page).not_to have_content("Welcome, test@test.com")
	end

end

feature 'forget password' do
	
	scenario "the user has forgetten his password" do
		visit('/users/reset_password')
		expect(page).to have_content("enter your adress:")
	end

	scenario "an email that is not in the db" do
		enter_email('bob@bob.com')
		expect(page).not_to have_content("email sent")
		expect(page).to have_content("wrong email bob")
	end

	feature " manage the token" do

		before(:each) do	
			user = User.create(
									:email => "test@test.com",
									:password_digest => "test",
									:password_token => "bob",
									:password_token_timestamp => Time.now)
		end

		scenario "cannot reset with the wrong token" do
			visit("/users/reset_password/bobo")
			expect(page).not_to have_content("token access validated")
			expect(page).to have_content('token invalid')
		end

		scenario "reset with the right token" do
			visit ("/users/reset_password/bob")
			expect(page).not_to have_content('token invalid')
			expect(page).to have_content("enter your new password:")
		end

		scenario "cannot reset if token is more than 1 hour old" do
			user = User.create(
									:email => "dave@dave.com",
									:password_digest => "test",
									:password_token => "dave",
									:password_token_timestamp => (Time.now - 100000))

			visit("/users/reset_password/dave")
			expect(page).not_to have_content("token access validated")
			expect(page).to have_content('token invalid')
		end

	end

	feature "rewrite password" do

		scenario "compare password and confirmation" do
			user = User.create(
									:email => "test@test.com",
									:password_digest => "test",
									:password_token => "bob",
									:password_token_timestamp => Time.now)
			enter_new_password("bobby", "bobby")
			expect(page).to have_content('password changed')
		end

			scenario "take the input of new password and link it to the db" do
				user = User.create(
									:email => "test@test.com",
									:password_digest => "test",
									:password_token => "bob",
									:password_token_timestamp => Time.now)
				password_orignal = user.password_digest
				enter_new_password("bobby", "bobby") 
				user = User.get(user.id)
				expect(user.password_digest).not_to eq(password_orignal)
			end

			scenario "check if he can log in with the new password" do
				user = User.create(
									:email => "test@test.com",
									:password_digest => "test",
									:password_token => "bob",
									:password_token_timestamp => Time.now)
				password_orignal = user.password_digest
				enter_new_password("bobby", "bobby") 
				user = User.get(user.id)
				expect(user.password_digest).not_to eq(password_orignal)
				visit('/')
				expect(page).not_to have_content("Welcome, test@test.com")
				sign_in('test@test.com', 'bobby')
				expect(page).to have_content("Welcome, test@test.com")
			end


end
end
