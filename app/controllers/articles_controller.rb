class ArticlesController < ApplicationController
  def index
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:success] = 'Article created successfully'
      redirect_to articles_path
    end
  end

  def article_params
    params.require(:article).permit(:body, :title)
  end
end
