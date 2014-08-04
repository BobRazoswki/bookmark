require 'spec_helper'

feature "User browses the list of peeps" do

  before(:each) {
    Peep.create(:message => "My first peep")
     Peep.create(:message => "My second peep")
      Peep.create(:message => "My third peep")
       Peep.create(:message => "My fourth peep")
  }

  scenario "when opening the home page" do
    visit '/'
    expect(page).to have_content("My first peep")
  end

  scenario "display peeps" do
    
  end

scenario "display peeps by chronological order" do
  
end

end