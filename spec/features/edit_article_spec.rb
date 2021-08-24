require 'rails_helper'

RSpec.feature "Update article" do
  before do
    @user = User.create(email: 'user@email.com', password: '123456')
    login_as(@user)
    @article = @user.articles.create(title: 'articleaa', body: 'bodyeee')
  end

  scenario "update an artilce" do
    visit article_url(@article.id)
    click_link "Edit"
    fill_in "Title", with: "new title"
    fill_in "Body", with: "updated body...."
    click_button "Update"
    expect(page).to have_content("article updated")
    expect(page.current_path).to eq(article_path(@article))
  end
end