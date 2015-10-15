require 'rails_helper'

feature "Deleting an Article" do
  
  before do
    marlon = User.create(email: "marlon@exemple.com", password: "password")
    login_as(marlon)
    @article = Article.create(title: "First Article", body: "body of first article", user: marlon)
  end

  scenario "A user deletes an article" do
    visit "/"

    click_link @article.title
    click_link "Delete Article"

    expect(page).to have_content("Article has been deleted")
    expect(current_path).to eq(articles_path)
  end
end
