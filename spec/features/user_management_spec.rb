require 'spec_helper'

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

	def sign_up(email= "alice@example.com", password = "oranges!", password_confirmation = "oranges!")
		visit('/users/new')
		expect(page.status_code).to eq 200
		fill_in :email, :with => email
		fill_in :password, :with => password
		fill_in :password_confirmation, :with => password_confirmation
		click_button "Sign up"
	end

end