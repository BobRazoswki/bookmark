module SessionHelpers

	def sign_up(email= "alice@example.com", password = "oranges!", password_confirmation = "oranges!")
		visit('/users/new')
		expect(page.status_code).to eq 200
		fill_in :email, :with => email
		fill_in :password, :with => password
		fill_in :password_confirmation, :with => password_confirmation
		click_button "Sign up"
	end

	def sign_in(email, password)
		visit('/sessions/new')
		fill_in 'email', :with => email
		fill_in 'password', :with => password
		click_button 'Sign in'
	end

	def enter_email(email = 'test@test.com')
		visit('/users/reset_password')
		fill_in 'email', :with => email
		click_button 'Submit'
	end

	def enter_token(token ="bob")
		visit("/users/reset_password/#{token}")
		save_and_open_page
		fill_in('password', with: '12345678')
		fill_in('confirmation', with: '12345678')
		click_button 'Bob submit'
	end

end