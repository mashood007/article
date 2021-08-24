class ArticlesController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_article, only: [:edit, :show, :update, :destroy]

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:success] = 'Article created successfully'
      redirect_to @article
    else
      flash.now[:danger] = "Article has not been created"
      render :new
    end
  end

  def show
  end

  def edit
    unless @article.user == current_user
      flash[:alert] = 'You can only edit your own article'
      redirect_to root_url
    end
  end

  def update
    if @article.user == current_user
      if @article.update(article_params)
        flash[:success] = "article updated"
        redirect_to @article
      end
    else
      flash[:alert] = 'You can only edit your own article'
    end
  end

  def destroy
    if @article.user == current_user
      if @article.destroy
        flash[:success] = "Deleted"
        redirect_to articles_path
      end
    else
      flash[:alert] = 'You can only delete your own article'
      redirect_to root_url
    end
  end

  private

  def find_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:body, :title)
  end

  protected

  def resource_not_found
    flash[:alert] = "Invalid Id"
    redirect_to root_url
  end
end
