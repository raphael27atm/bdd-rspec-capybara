require 'rails_helper'

feature "Showing an Article" do
  
  before do
    @marlon = User.create(email: "marlon@exemple.com", password: "password")
    @raphael = User.create(email: "raphael@exemple.com", password: "password")
    @article = Article.create(title: "First Article", body: "body of first article", user: @marlon)
  end

  scenario "A signed in owner sees both links" do
    login_as(@marlon)

    visit "/"

    click_link @article.title
    
    expect(page).to have_link("Edit Article")
    expect(page).to have_link("Delete Article")
  end

  scenario "A non-owner signed in cannot see both links" do
    login_as(@raphael)

    visit "/"

    click_link @article.title
    
    expect(page).not_to have_link("Edit Article")
    expect(page).not_to have_link("Delete Article")
  end
  
  scenario "A non-signed in user does not see Edit or Delete links " do
    visit "/"

    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))

    expect(page).not_to have_link("Edit Article")
    expect(page).not_to have_link("Delete Article")
    
  end
  
  scenario "Display individual article" do
    visit "/"

    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))
  end
end
