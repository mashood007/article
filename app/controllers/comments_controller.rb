class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_article

  def create
    @comment = @article.comments.new(comment_params)
    @comment.user = current_user
    if @comment.save!
      ActionCable.server.broadcast "comments_channel",
        render(partial: 'comments/comment', object: @comment )
      flash[:success] = 'comment has been created'
    else
      flash[:alert] == 'error'
    end
    # redirect_to @article
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_article
    @article = Article.find(params[:article_id])
  end
end
