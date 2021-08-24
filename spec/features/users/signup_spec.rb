require 'rails_helper'
RSpec.feature 'signup' do
  scenario 'Sunccess' do
    visit root_url
    click_link 'Signup'
    fill_in 'Email', with: 'example@test.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign up'
    expect(page).to have_content('Welcome! You have signed up successfully')
  end

  scenario 'empty all fields' do
    visit root_url
    click_link 'Signup'
    fill_in 'Email', with: ''
    fill_in 'Password', with: ''
    fill_in 'Password confirmation', with: ''
    click_button 'Sign up'
    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("Password can't be blank")
  end
end