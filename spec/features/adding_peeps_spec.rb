require 'spec_helper'
require './spec/helpers/session'


feature "User adds a new peep" do
include SessionHelpers
before(:each) {
	User.create(  :user_handle => "handle",
								:name => "name",
								:email => "test@test.com",
								:password => "test",
								:password_confirmation => "test")
	sign_in("test@test.com","test")
}
	scenario "When browsing the homepage" do
		expect(Peep.count).to eq 0
		visit ('/')
		add_peep("My first peep")
		expect(Peep.count).to eq(1)
		peep = Peep.first
		expect(peep.message).to eq("My first peep")
	end

	scenario "peep with user name" do
		visit '/peeps/new'
		add_peep "My first peep"
		visit ('/')
		peep = Peep.first
		expect(page).to have_content("My first peep")
	end

  def add_peep(message)
    within('#new-peep') do
    fill_in 'message', :with => message
    click_button 'Peep!'
    end      
  end


end

