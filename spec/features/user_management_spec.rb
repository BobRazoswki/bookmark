require 'spec_helper'
require_relative '../../app/helpers/session'

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

end

