module SessionHelpers

	def sign_up(user_handle="@alice", email= "alice@example.com", password = "oranges!", password_confirmation = "oranges!")
		visit('/users/new')
		expect(page.status_code).to eq 200
		fill_in :user_handle, with => user_handle
		fill_in :name, with => user_handle
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
		fill_in('password', with: '12345678')
		fill_in('confirmation', with: '12345678')
		click_button 'Bob submit'
	end

	def enter_new_password(password, confirmation)
			visit("/users/reset_password/bob")
			fill_in 'password', :with => "bobby"
			fill_in 'confirmation', :with => "bobby"
			click_button('Bob submit')
	end

end