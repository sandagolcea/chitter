  def sign_up(name = "Sanda", 
              user_name = "pianogrl",
              email = "sanda@example.com",
              password = "oranges!",
              password_confirmation = "oranges!")
    visit '/makers/new'
    expect(page.status_code).to eq(200)
    fill_in :name, :with => name
    fill_in :user_name, :with => user_name
    fill_in :email, :with => email
    fill_in :password, :with => password
    fill_in :password_confirmation, :with => password_confirmation
    click_button "Sign up"
  end

  def sign_in(email, password)
    visit '/sessions/new'
    fill_in 'email', :with => email
    fill_in 'password', :with => password
    click_button 'Sign in'
  end

  def sign_out
    visit '/'
    click_button 'Sign out'
  end