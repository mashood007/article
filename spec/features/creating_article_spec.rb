require 'rails_helper'
RSpec.feature "Create article" do
  before do
    @user = User.create(email: 'user@email.com', password: '123456')
    
  end

  scenario "A user creating an article" do
    login_as(@user)
    visit "/"
    
    # click new article button
    click_link "New Article"
    
    # fill title 
    fill_in "Title", with: "my first blog"

    # fill body
    fill_in "Body", with: 'blog body is this'
    
    # click save
    click_button "Create"
    expect(Article.last.user).to eq(@user)
    expect(page).to have_content("Article created successfully")
    expect(page).to have_content("created by : #{@user.email}")
    expect(page.current_path).to eq(article_path(Article.last.id))

  end


  scenario "creating an article without userlogin" do
    visit "/"
    expect(page).not_to have_link("New Article")
  end  

  scenario "A user creating an article without body and title" do
    login_as(@user)
    visit "/"
    click_link "New Article"
    fill_in "Title", with: ""
    fill_in "Body", with: ''
    click_button "Create"

    expect(page).to have_content("Article has not been created")
    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content("Body can't be blank")
  end
end