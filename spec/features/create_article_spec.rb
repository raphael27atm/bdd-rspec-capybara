require 'rails_helper'

feature "Creating Articles" do
  def create_article option={}
    option[:title] ||= "Create firt Article"
    option[:body] ||= "Lorem Ipsum"

    visit "/"

    click_link "New Article"

    fill_in "Title", with: option[:title]
    fill_in "Body", with: option[:body]
    click_button "Create Article"
  end

  before do
    @marlon = User.create!(email: "marlon@exemple.com", password: "password")
    login_as(@marlon)
  end
  
  scenario "A user a new article" do
    create_article
    expect(page).to have_content("Article has been created")
    expect(page.current_path).to eq(articles_path)
    expect(page).to have_content("Created by: #{@marlon.email}")
  end

  scenario "A user fails to create a new article" do
    create_article(title: "", body: "")
    expect(page).to have_content("Article has not been created")
    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content("Body can't be blank")
  end
end
