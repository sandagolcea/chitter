require 'spec_helper'

feature "Maker signs up" do

  scenario "when being a new maker visiting the site" do
    expect{ sign_up }.to change(Maker, :count).by(1)
    expect(page).to have_content("Welcome, sanda@example.com")
    expect(Maker.first.name).to eq("Sanda")
    expect(Maker.first.user_name).to eq("pianogrl")
    expect(Maker.first.email).to eq("sanda@example.com")
  end

  def sign_up(name = "Sanda", 
              user_name = "pianogrl",
              email = "sanda@example.com",
              password = "oranges!")
    visit '/makers/new'
    expect(page.status_code).to eq(200)
    fill_in :name, :with => name
    fill_in :user_name, :with => user_name
    fill_in :email, :with => email
    fill_in :password, :with => password
    click_button "Sign up"
  end

end