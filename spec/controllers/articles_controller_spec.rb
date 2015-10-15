require 'rails_helper'
require 'support/macros'

RSpec.describe ArticlesController, type: :controller do

  describe "GET #edit" do
    before do
      @marlon = User.create(email: "marlon@exemple.com", password: "password")
    end

    context "owner is allowed to edit his articles" do
      it "renders the edit template" do
        login_user @marlon
        article = Article.create(title: "first article", body: "body of article", user: @marlon)

        get :edit, id: article
        expect(response).to render_template :edit
      end
    end

    context "non-owner is not allowend to edit other users articles" do
      it "redirect to the root path" do
        raphael =  User.create(email: "raphael@exemple.com", password: "password")
  
        login_user raphael
         
        article = Article.create(title: "first article", body: "body of article", user: @marlon)

        get :edit, id: article
        expect(response).to redirect_to(root_path)
        message = "You can only edit your own article."
        expect(flash[:danger]).to eq message
      end
    end
    
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

end
