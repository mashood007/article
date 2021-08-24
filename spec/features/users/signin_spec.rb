require 'rails_helper'

RSpec.feature 'User login' do
  before do
    @user = User.create(email: 'user@email.com', password: '123456')
  end

  scenario "valid user login" do
    visit root_url
    click_link 'Signin'
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log in'
    expect(page).to have_content('Welcome')
    expect(page).to have_content("Signed in as #{@user.email}") 
    expect(page).not_to have_link("Sign in")
    expect(page).not_to have_link("Sign up")
  end
end