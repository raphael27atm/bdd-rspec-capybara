require 'rails_helper'

feature "Creating Articles" do
  scenario "A user a new article" do
    visit "/"

    click_link "New Article"

    fill_in "Title", with: "Create first Article"
    fill_in "Body", with: "lorem Ipsum"
    click_button "Create Article"

    expect(page).to have_content("Article has been created")
    expect(page.current_path).to eq(articles_path)

  end
end
