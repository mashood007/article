require 'rails_helper'

RSpec.feature 'deleting an article' do
  before do
    @user = User.create(email: 'user@email.com', password: '123456')
    login_as(@user)
    @article = @user.articles.create(title: 'articleaa', body: 'bodyeee')
  end

  scenario 'delete article successfully' do
    visit article_path @article
    click_link 'Delete'
    expect(page).to have_content('Deleted')
    expect(page.current_path).to eq articles_path
  end
end