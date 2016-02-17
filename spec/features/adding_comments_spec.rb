require "rails_helper"
RSpec.feature "Adding Reviews to Articles" do

  before do
    create_users_and_article
  end

  scenario "permits a signed in user to write a review" do
    comment_body = "An awesome article"

    login_as(@fred)
    create_comment comment_body
    expect_article_page_with_comment_displayed comment_body
  end

  def expect_article_page_with_comment_displayed(comment_body)
    expect(page.current_path).to eq(article_path(@article.comments.last.id))
    expect(page).to have_content "Comment has been created"
    expect(page).to have_content comment_body
  end

  def create_comment(comment_body)
    visit "/"
    click_link @article.title
    fill_in "New Comment", with: comment_body
    click_button "Add Comment"
  end

  def create_users_and_article
    title = "The first article"
    body = "Body of first article"
    @john = User.create(email: "fred@example.com", password: "password")
    @fred = User.create(email: "john@example.com", password: "password")
    @article =Article.create(title: title, body: body, user: @john)
  end
end
