require "rails_helper"

RSpec.feature 'showing on article' do

  before do
    @article = Article.create(title: "The first article", body: "Lorem ipsum one")
  end
  scenario 'A user show an article' do

    visit "/"
    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))

  end


end