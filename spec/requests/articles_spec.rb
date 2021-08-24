require 'rails_helper'

RSpec.describe "Articles", type: :request do
  before do
    @smith = User.create(email: 'smith@email.com', password: '123456')
    @samson = User.create(email: 'samson@email.com', password: '123456')
    @article = Article.create(title: 'a1', body: 'a1 body', user: @smith)
  end
  # describe "GET /index" do
  #   it "returns http success" do
  #     get "/articles/index"
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  describe "GET article/:id/edit" do
    context "non signed user" do
      before { get "/articles/#{@article.id}/edit"}
      it "redirect to login page" do
        expect(response.status).to eq 302
        flash_message = 'You need to sign in or sign up before continuing.'
        expect(flash[:alert]).to eq flash_message
      end
    end

    context "Non owner" do
      before do
        login_as(@samson)
        get "/articles/#{@article.id}/edit"
      end

      it "redirect to home page" do
        expect(response.status).to eq 302
        flash_message = 'You can only edit your own article'
        expect(flash[:alert]).to eq flash_message
      end
    end

    context "owner" do
      before do
        login_as(@smith)
        get "/articles/#{@article.id}/edit"
      end

      it "redirect to home page" do
        expect(response.status).to eq 200
      end
    end
  end

  context "Valid ID" do
    describe "GET article/:id" do
      before { get "/articles/#{@article.id}"}

      it "get an article by valid Id" do
        expect(response).to have_http_status(:success)
      end
    end
  end

  context 'Invalid ID' do
    describe "GET article/:id" do
      before { get "/articles/12" }
      it "get invalid article ID"  do
        expect(response).to have_http_status 302
        flash_message = "Invalid Id"
        expect(flash[:alert]).to eq flash_message
      end
    end
  end


  describe 'DELETE article/:id' do
    context 'un signed user delete' do
      before { delete "/articles/#{@article.id}" }
      it 'redirect_to login page' do
        expect(response.status).to eq 302
        flash_message = 'You need to sign in or sign up before continuing.'
        expect(flash[:alert]).to eq flash_message
      end
    end

    context 'non-Owner signed delete' do
      before do
        login_as(@samson)
        delete "/articles/#{@article.id}"
      end
      
      it 'redirect to home' do
        expect(response.status).to eq 302
        flash_message = 'You can only delete your own article'
        expect(flash[:alert]).to eq flash_message
      end
    end

    context 'Owner signed delete' do
      before do
        login_as(@smith)
        delete "/articles/#{@article.id}"
      end

      it 'delete success' do
        expect(flash[:success]).to eq "Deleted"
      end
    end
  end
end
