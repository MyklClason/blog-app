require "rails_helper"
RSpec.feature "Listing Articles" do

  before do
    create_articles
  end

  scenario "List all articles" do
    visit "/"

    expect_article_displayed_with_link(@article1)
    expect_article_displayed_with_link(@article2)
    expect(page).not_to have_link("New Article")
  end

  def expect_article_displayed_with_link(article)
    expect(page).to have_content(article.title)
    expect(page).to have_content(article.body)

    expect(page).to have_link(article.title)
  end
  
  def create_articles
    @article1 = Article.create(title: "The first article", body: "Body of first article")
    @article2 = Article.create(title: "The second article", body: "Body of second article")
    @article3 = Article.create(title: "The second article", body: "Body of second article")
  end

end
