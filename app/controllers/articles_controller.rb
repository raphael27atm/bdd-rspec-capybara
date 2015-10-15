class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  
  def index
    @articles = Article.all
  end

  def show

  end
  
  def new
    @article = Article.new
  end

  def create
    @article = article_build
    if @article.save
      flash[:success] = "Article has been created"
      redirect_to articles_path
    else
      flash.now[:danger] = "Article has not been created"
      render :new
    end
  end

  def edit

  end
  
  def update
    if @article.update(article_params)
      flash[:success] = "Article has been updated"
      redirect_to @article
    else
      flash.now[:danger] = "Article has not been updated"
      render :edit
    end
  end

  def destroy
    if @article.destroy
      flash[:success] = "Article has been deleted"
      redirect_to articles_path
    end
  end
  
  private

  def set_article
    @article = Article.find(params[:id])
  end
    
  def article_build
    current_user.articles.build(article_params)
  end

  def article_params
    params.require(:article).permit(
      :title,
      :body,
      :user_id
    )
  end
end
