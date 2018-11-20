require "rails_helper"

RSpec.feature 'Adding reviews to Articles' do
  before do
    @user = User.create!(email: 'user@example.com', password: 'password')
    @user1 = User.create!(email: 'user1@example.com', password: 'password1')
    @user2 = User.create!(email: 'user2@example.com', password: 'password1')
    @user3 = User.create!(email: 'user3@example.com', password: 'password1')

    @article = Article.create!(title: "The first article", body: "Lorem ipsum one", user: @user)

  end

  scenario "permits a signed in user to write a review" do
    login_as(@user1)

    visit "/"

    click_link @article.title
    fill_in "New Comment", with: "An amazing article"
    click_button "Create Comment"

    expect(page).to have_content("Comment has been created")
    expect(page).to have_content("An amazing article")
    expect(current_path).to eq(article_path(@article.id))

  end

end