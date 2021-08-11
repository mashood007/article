require 'rails_helper'
RSpec.feature "Create article" do
  scenario "A user creating an article" do
    # visit root page
    visit "/"
    
    # click new article button
    click_link "New Article"
    
    # fill title 
    fill_in "Title", with: "my first blog"

    # fill body
    fill_in "Body", with: 'blog body is this'
    
    # click save
    click_button "Create"

    expect(page).to have_content("Article created successfully")
    expect(page.current_path).to eq(articles_path)
    #article craeted toast
    #goto articles path
  end
end