require 'spec_helper'

feature "Maker adds a new peep" do
  scenario "when browsing the homepage" do
    expect(Peep.count).to eq(0)
    visit '/'
    add_peep("Sanda","pianogrl","Hello world")
    expect(Peep.count).to eq(1)
    peep = Peep.first
    expect(peep.name).to eq("Sanda")
    expect(peep.user_handle).to eq("pianogrl")
    expect(peep.message).to eq("Hello world")
  end

  def add_peep(name,user_handle,message)
    within('#new-peep') do
      fill_in 'name', :with => name
      fill_in 'user_handle', :with => user_handle
      fill_in 'message', :with => message
      click_button 'Add peep'
    end
  end
end