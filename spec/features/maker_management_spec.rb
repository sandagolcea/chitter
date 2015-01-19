require 'spec_helper'
require_relative './helpers/session'

feature "Maker signs up" do

  scenario "when being a new maker visiting the site" do
    expect{ sign_up }.to change(Maker, :count).by(1)
    expect(page).to have_content("Welcome, sanda@example.com")
    expect(Maker.first.name).to eq("Sanda")
    expect(Maker.first.user_name).to eq("pianogrl")
    expect(Maker.first.email).to eq("sanda@example.com")
  end

  scenario "with a password that doesn't match" do
    expect{ sign_up('Alice','princess', 'a@a.com', 'pass', 'wrong') }.to change(Maker, :count).by(0)
    expect(current_path).to eq('/makers')
    expect(page).to have_content("Sorry, your passwords don't match")
  end

  scenario "with an email that is already registered" do
    expect{ sign_up }.to change(Maker, :count).by(1)
    sign_out
    expect{ sign_up('Sanda','girl', 'sanda@example.com') }.to change(Maker, :count).by(0)
    expect(page).to have_content("This email is already taken")
  end

  scenario "with a user name that is already registered" do
    expect{ sign_up }.to change(Maker, :count).by(1)
    sign_out
    expect{ sign_up('Sanda','pianogrl', 'a@a.com') }.to change(Maker, :count).by(0)
    expect(page).to have_content("This user name is already taken")
  end

end

feature "Maker signs in" do

  before(:each) do
    Maker.create(name: "Sanda",
                user_name: "pianogrl",
                email: "test@test.com",
                password: 'test',
                password_confirmation: 'test')
  end

  scenario "with correct credentials" do
    visit '/'
    expect(page).not_to have_content("Welcome, test@test.com")
    sign_in('test@test.com', 'test')
    expect(page).to have_content("Welcome, test@test.com")
  end

  scenario "with incorrect credentials" do
    visit '/'
    expect(page).not_to have_content("Welcome, test@test.com")
    sign_in('test@test.com', 'wrong')
    expect(page).not_to have_content("Welcome, test@test.com")
  end

  def sign_in(email, password)
    visit '/sessions/new'
    fill_in 'email', :with => email
    fill_in 'password', :with => password
    click_button 'Sign in'
  end

end

feature 'Maker signs out' do

  before(:each) do
    Maker.create(name: "Sanda",
                user_name: "pianogrl",
                email: "test@test.com",
                password: 'test',
                password_confirmation: 'test')
  end

  scenario 'while being signed in' do
    sign_in('test@test.com', 'test')
    click_button "Sign out"
    expect(page).to have_content("Goodbye!") # where does this message go?
    expect(page).not_to have_content("Welcome, test@test.com")
  end

end