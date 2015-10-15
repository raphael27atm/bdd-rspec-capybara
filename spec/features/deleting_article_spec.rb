require 'rails_helper'

feature "Deleting an Article" do
  before do
    @article = Article.create(title: "First Article", body: "Body of first article")
  end

  scenario "A user deletes an article" do
    visit "/"

    click_link @article.title
    click_link "Delete Article"

    expect(page).to have_content("Article has been deleted")
    expect(current_path).to eq(articles_path)
  end
end
