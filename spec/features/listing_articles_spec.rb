require 'rails_helper'
RSpec.feature "Listing articles" do
  before do
    @user = User.create(email: 'user@email.com', password: '123456')
    @article1 = @user.articles.create(title: 'a1', body: 'a1 body')
    @article2 = @user.articles.create(title: 'a2', body: 'a2 body')
  end

  scenario "list two articles" do
    visit root_url
    expect(page).to have_content(@article1.title)
    expect(page).to have_content(@article1.body)
    expect(page).to have_content(@article2.title)
    expect(page).to have_content(@article2.body)
    expect(page).to have_link(@article1.title)
    expect(page).to have_link(@article2.title)
  end

  scenario "no articles" do
    Article.delete_all
    
    visit root_url
    expect(page).not_to have_content(@article1.title)
    expect(page).not_to have_content(@article1.body)
    expect(page).not_to have_content(@article2.title)
    expect(page).not_to have_content(@article2.body)
    expect(page).not_to have_link(@article1.title)
    expect(page).not_to have_link(@article2.title)

    within("h1#no-article") do 
      expect(page).to have_content("No articles")
    end
  end
end