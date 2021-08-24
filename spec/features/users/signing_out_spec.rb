require 'rails_helper'
RSpec.feature 'User Signout' do
    before do
      @user = User.create(email: 'user@email.com', password: '123456')
      visit root_url
      click_link 'Signin'
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      click_button 'Log in'
    end
  
    scenario "User logout" do
      visit root_url
      click_link 'Sign out'
      expect(page).to have_content('Signed out successfully')
      expect(page).not_to have_content('Sign out')
    end
  end