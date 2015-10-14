class ArticlesController < ApplicationController
  def index
  end

  def new
    @article = Article.new
  end

  def create
    @article = article_build
    @article.save
    flash[:success] = "Article has been created"
    redirect_to articles_path
  end

  private
    
  def article_build
    Article.new(article_params)
  end

  def article_params
    params.require(:article).permit(
      :title,
      :body
    )
  end
end
