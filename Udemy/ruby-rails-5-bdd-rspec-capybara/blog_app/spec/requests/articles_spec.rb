require "rails_helper"

RSpec.describe "Articles", type: :request do

  before do
    @user = User.create!(email: 'user@example.com', password: 'password')
    @user1 = User.create!(email: 'user1@example.com', password: 'password1')
    @article = Article.create!(title: "The first article", body: "Lorem ipsum one", user: @user)
  end

  describe 'GET /articles/:id/edit' do
    context 'with non-signed in user' do
      before {get "/articles/#{@article.id}/edit"}

      it "Redirects to the signin page" do
        expect(response.status).to eq 302
        flash_message = "You need to sign in or sign up before continuing."
        expect(flash[:alert]).to eq flash_message
      end
    end

    context 'with signed in user who is non-owner' do
      before do
        login_as(@user1)
        get "/articles/#{@article.id}/edit"
      end

      it "redirects to the home page" do
        expect(response.status).to eq 302
        flash_message = "You can only edit your own article."
        expect(flash[:alert]).to eq flash_message
      end
    end

    context 'with signed in user as owner successful edit' do
      before do
        login_as(@user)
        get "/articles/#{@article.id}/edit"
      end

      it "successfully edits article" do
        expect(response.status).to eq 200
      end

    end

  end

  describe 'GET /articles/:id' do
    context 'with existing article' do
      before {get "/articles/#{@article.id}"}

      it "handles existing article" do
        expect(response.status).to eq 200
      end
    end

    context 'with non-existing article' do
      before {get "/articles/99999"}

      it "handless non-existing article" do
        expect(response.status).to eq 302
        flash_message = "The article you are looking for could not be found"
        expect(flash[:alert]).to eq flash_message
      end
    end


  end
end