require 'spec_helper'
require_relative 'helpers/session'

feature 'replies' do
	include SessionHelpers
				before(:each) do
					User.create(  
								:user_handle => "handle",
								:name => "name",
								:email => "test@test.com",
								:password => "test",
								:password_confirmation => "test")
					sign_in("test@test.com","test")
				end

	scenario "When browsing the homepage" do
		expect(Peep.count).to eq 0
		visit ('/')
		add_peep("My first peep")
		expect(Peep.count).to eq(1)
		peep = Peep.first
		expect(peep.message).to eq("My first peep")
		visit '/replies/new'
		add_reply("My first reply")
	end

  def add_peep(message)
    within('#new-peep') do
    fill_in 'message', :with => message
    click_button 'Peep!'
    end      
  end

  def add_reply(message)
    within('#new-reply') do
    fill_in 'message', :with => message
    click_button 'Reply!'
    end      
  end

end