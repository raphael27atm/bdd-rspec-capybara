require 'rails_helper'

feature "Signing out signed-in users" do
  before do
    @marlon = User.create!(email: "marlon@exemple.com", password: "password")
    visit "/"

    click_link "Sign in"
    fill_in "Email", with: @marlon.email
    fill_in "Password", with: @marlon.password
    click_button "Log in"
  end
  
  scenario do
    visit "/"
    click_link "Sign out"
    expect(page).to have_content("Signed out successfully.")
  end

end

