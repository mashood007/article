require 'rails_helper'

RSpec.describe "Comments", type: :request do
  before do
    @smith = User.create(email: 'smith@email.com', password: '123456')
    @samson = User.create(email: 'samson@email.com', password: '123456')
    @article = Article.create(title: 'a1', body: 'a1 body', user: @smith)
  end

  describe "POST articles/:id/comments" do
    context 'un signed user post comment' do
      before { post "/articles/#{@article.id}/comments", params: { comment: { content: 'my comment..' } } }
      it 'redirect_to login page' do
        expect(response.status).to eq 302
        flash_message = 'You need to sign in or sign up before continuing.'
        expect(flash[:alert]).to eq flash_message
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'signed user post' do
      before do
        login_as(@samson)
        post "/articles/#{@article.id}/comments", params: { comment: { content: 'my comment..' } }
      end
      
      it 'comments created successfully' do
        expect(response.status).to eq 302
        flash_message = 'comment has been created'
        expect(flash[:success]).to eq flash_message
        expect(response).to redirect_to(article_path(@article.id))
      end
    end

  end
end