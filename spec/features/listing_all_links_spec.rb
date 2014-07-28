require 'spec_helper'

feature "Use browses the list of links" do
	
	before(:each) {
		Link.create(:url => "http://www.makeracademy.com",
			:title => "Makers Academy")
	}

	scenario "When opening the homepage" do
		visit '/'
		expect(page).to have_content("Makers Academy")
	end
end