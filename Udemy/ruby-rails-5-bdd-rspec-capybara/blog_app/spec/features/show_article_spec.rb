require "rails_helper"

RSpec.feature 'showing on article' do

  before do
    @user = User.create!(email: 'user@example.com', password: 'password')
    @user1 = User.create!(email: 'user1@example.com', password: 'password')
    @article = Article.create(title: "The first article", body: "Lorem ipsum one", user: @user)
  end
  scenario 'To non-signed in user hide the Edit and Delete buttons' do

    visit "/"
    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))

    expect(page).not_to have_link("Edit Article")
    expect(page).not_to have_link("Delete Article")
  end

  scenario 'To non-owner hide the Edit and Delete buttons' do
    login_as(@user1)
    visit "/"
    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))

    expect(page).not_to have_link("Edit Article")
    expect(page).not_to have_link("Delete Article")
  end

  scenario 'A signed in owner see the Edit and Delete Buttons' do
    login_as(@user)
    visit "/"
    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))

    expect(page).to have_link("Edit Article")
    expect(page).to have_link("Delete Article")
  end


end