require "rails_helper"

RSpec.describe "Comments", type: :request do

  before do
    @user = User.create!(email: 'user@example.com', password: 'password')
    @user1 = User.create!(email: 'user1@example.com', password: 'password1')
    @article = Article.create!(title: "The first article", body: "Lorem ipsum one", user: @user)
  end

  describe 'POST /articles/:id/comments' do
    context 'with a non signed-in user' do
      before do
        post "/articles/#{@article.id}/comments", params: {comment: {body: "Awesome blog"}}

      end

      it "redirect user to the signin page" do
        flash_message = "Please sign in or sign up first"
        expect(response).to redirect_to(new_user_session_path)
        expect(response.status).to eq 302
        expect(flash[:alert]).to eq flash_message
      end
    end

    context 'with a logged in user' do
      before do
        login_as(@user1)
        post "/articles/#{@article.id}/comments", params: {comment: {body: "Awesome blog"}}

      end

      it "Create the comment successfully" do
        flash_message = "Comment has been created"
        expect(response).to redirect_to(article_path(@article.id))
        expect(response.status).to eq 302
        expect(flash[:notice]).to eq flash_message

      end

    end



  end

end