require 'spec_helper'

feature "User adds a new peep" do

	scenario "When browsing the homepage" do
		expect(Peep.count).to eq 0
		visit ('/')
		add_peep("My first peep")
		expect(Peep.count).to eq 1
		peep = Peep.first
		expect(peep.message).to eq ("My first peep")
	end

	scenario "peep with user name" do
		visit '/peeps/new'
		add_peep "My first peep"
		visit ('/')
		peep = Peep.first
		expect(page).to have_content("My first peep")
	end

  def add_peep(url, title, tags = [])
    within('#new-peep') do
      fill_in 'message', :with => message
      click_button 'Peep!'
    end      
  end

end

