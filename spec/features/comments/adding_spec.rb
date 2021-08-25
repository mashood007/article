require 'rails_helper'

RSpec.feature 'Adding comments' do
  before do
    @user1 = User.create(email: 'user@email.com', password: '123456')
    @user2 = User.create(email: 'user2@email.com', password: '123456')
    @article = @user1.articles.create(title: 'a1', body: 'a1 body')
  end

  scenario "added comments : success" do
    login_as(@user2)
    visit root_url
    
    click_link @article.title
    fill_in 'New comment', with: 'my first comment'
    click_button 'Add comment'

    expect(page).to have_content('my first comment')
    expect(page).to have_content('comment has been created')
    expect(current_path).to eq article_path(@article.id)
  end

end