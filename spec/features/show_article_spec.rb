require 'rails_helper'
RSpec.feature "show article" do
  before do
    @user = User.create(email: 'user@email.com', password: '123456')
    @user2 = User.create(email: 'user2@email.com', password: '123456')
    @article = @user.articles.create(title: 'a1', body: 'a1 body')
  end

  scenario "shows article for unsigned" do
    visit root_url
    click_link @article.title
    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(page).not_to have_link("Delete")
    expect(page).not_to have_link("Edit")
    expect(current_path).to eq(article_path @article)
  end

  scenario "shows article for non-owner user signed" do
    login_as(@user2)
    visit root_url
    click_link @article.title
    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(page).not_to have_link("Delete")
    expect(page).not_to have_link("Edit")
    expect(current_path).to eq(article_path @article)
  end

  scenario "shows article for owner user signed" do
    login_as(@user)
    visit root_url
    click_link @article.title
    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(page).to have_link("Delete")
    expect(page).to have_link("Edit")
    expect(current_path).to eq(article_path @article)
  end  

end