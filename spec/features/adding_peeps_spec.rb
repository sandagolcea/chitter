require 'spec_helper'
require_relative './helpers/session'
require 'chitter'

feature "Maker adds a new peep" do
  
  before(:each) {
    sign_up
  }

  after(:each) {
    sign_out
  }

  scenario "when browsing the homepage" do
    expect(Peep.count).to eq(0)
    visit '/'
    add_peep("Hello world")
    expect(Peep.count).to eq(1)
    peep = Peep.first
    expect(peep.message).to eq("Hello world")
  end

  scenario "with a few hashtags" do
    visit '/'
    add_peep("Hello world", ["code","study"])
    peep = Peep.first
    expect(peep.hashtags.map(&:text)).to include("code")
    expect(peep.hashtags.map(&:text)).to include("study")
  end



  def add_peep(message,hashtags=[])
    within('#new-peep') do
      fill_in 'message', :with => message
      fill_in 'hashtags', :with => hashtags.join(' ')
      click_button 'Add peep'
    end
  end
end