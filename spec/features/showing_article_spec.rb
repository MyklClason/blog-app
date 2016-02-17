require "rails_helper"
RSpec.feature "Showing an Article" do
  before do
    create_users_and_articles
  end

  scenario "A non-signed in user does not see Edit or Delete links" do
    goto_article_page
    expect_article_displayed_without_actions
  end

  scenario "Non-creator in user does not see Edit or Delete links" do
    login_as(@noncreator)
    goto_article_page
    expect_no_actions_displayed
  end

  scenario "Creator sees Edit and Delete links" do
    login_as(@creator)
    goto_article_page
    expect_actions_displayed
  end

  scenario "Display individual article" do
    goto_article_page
    expect_article_displayed
  end

  # ---------------------------------------------------
  # -------------------- Helpers ----------------------
  # ---------------------------------------------------

  def expect_article_displayed_without_actions
    expect_article_displayed
    expect_no_actions_displayed
  end

  def expect_article_displayed_with_actions
    expect_article_displayed
    expect_actions_displayed
  end

  def expect_no_actions_displayed
    expect(page).not_to have_link("Edit Article")
    expect(page).not_to have_link("Delete Article")
  end

  def expect_actions_displayed
    expect(page).to have_link("Edit Article")
    expect(page).to have_link("Delete Article")
  end

  def expect_article_displayed
    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))
  end

  def create_users_and_articles
    creator_email = "john@example.com"
    noncreator_email = "fred@example.com"
    title = "The first article"
    body = "Body of first article"
    @creator = User.create(email: creator_email, password: "password")
    @noncreator = User.create(email: noncreator_email, password: "password")
    @article = Article.create(title: title, body: body, user: @creator)
  end

  def goto_article_page
    visit "/"
    click_link @article.title
  end
end