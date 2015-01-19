require 'spec_helper'
require_relative './helpers/session'
require 'chitter'

feature "User browses the list of peeps" do

  before(:each) {
    current_maker = Maker.create(name: "Sanda",
                user_name: "pianogrl",
                email: "test@test.com",
                password: 'test',
                password_confirmation: 'test')

    Peep.create(
                  message: "Hello world",
                  hashtags: [Hashtag.first_or_create(:text => "code")],
                  maker: current_maker)
    Peep.create(
                  message: "Go to code",
                  hashtags: [Hashtag.first_or_create(:text => "code")],
                  maker: current_maker)
    Peep.create(
                  message: "I say makers",
                  hashtags: [Hashtag.first_or_create(:text => "makers")],
                  maker: current_maker)
    Peep.create(
                  message: "I'm starting a new world",
                  hashtags: [Hashtag.first_or_create(:text => 'world')],
                  maker: current_maker)
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