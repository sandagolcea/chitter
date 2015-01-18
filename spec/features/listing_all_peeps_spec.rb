require 'spec_helper'

feature "User browses the list of peeps" do

  before(:each) {
    Peep.create(name: 'Sanda',
                  user_handle: 'pianogrl',
                  message: "Hello world")
  }

  scenario "when opening the home page" do
    visit '/'
    expect(page).to have_content("Hello world")
  end
end