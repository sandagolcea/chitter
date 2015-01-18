require 'spec_helper'

feature "User browses the list of peeps" do

  before(:each) {
    Peep.create(name: 'Sanda',
                  user_handle: 'pianogrl',
                  message: "Hello world",
                  hashtags: [Hashtag.first_or_create(:text => "code")])
    Peep.create(name: 'Sanda',
                  user_handle: 'pianogrl',
                  message: "Go to code",
                  hashtags: [Hashtag.first_or_create(:text => "code")])
    Peep.create(name: 'Sam',
                  user_handle: 'tansaku',
                  message: "I say makers",
                  hashtags: [Hashtag.first_or_create(:text => "makers")])
    Peep.create(name: 'Jair',
                  user_handle: 'codeguy',
                  message: "I'm starting a new world",
                  hashtags: [Hashtag.first_or_create(:text => 'world')])
  }


  scenario "when opening the home page" do
    visit '/'
    expect(page).to have_content("Hello world")
  end

  scenario "filtered by a tag" do
    visit '/hashtags/code'
    expect(page).not_to have_content("I say makers")
    expect(page).not_to have_content("I'm starting a new world")
    expect(page).to have_content("Go to code")
    expect(page).to have_content("Hello world")
  end

end