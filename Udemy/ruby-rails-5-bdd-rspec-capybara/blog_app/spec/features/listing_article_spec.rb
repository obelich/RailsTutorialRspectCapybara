require "rails_helper"

RSpec.feature "Listing Articles" do

  before do #Esto funciona para hacer algo antes de procesar el testing
    @user = User.create!(email: 'user@example.com', password: 'password')
    @article1 = Article.create(title: "The first article", body: "Lorem ipsum one", user: @user)
    @article2 = Article.create(title: "The second article", body: "Lorem ipsum two", user: @user)

  end

  scenario "A user lists all articles" do
    visit "/"

    expect(page).to have_content(@article1.title)
    expect(page).to have_content(@article1.body)
    expect(page).to have_content(@article2.title)
    expect(page).to have_content(@article2.body)
    expect(page).to have_link(@article1.title)
    expect(page).to have_link(@article2.title)

  end

  scenario "A user lists has no articles" do
    Article.delete_all
    visit "/"

    expect(page).not_to have_content(@article1.title)
    expect(page).not_to have_content(@article1.body)
    expect(page).not_to have_content(@article2.title)
    expect(page).not_to have_content(@article2.body)
    expect(page).not_to have_link(@article1.title)
    expect(page).not_to have_link(@article2.title)

    within ("h1#no-articles") do
      expect(page).to have_content("No Articles Created")
    end

  end

end