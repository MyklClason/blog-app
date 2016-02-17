require 'rails_helper'

RSpec.feature "Creating Articles" do
  before do
    @john = User.create(email: "john@example.com", password: "password")
    login_as(@john)
  end

  scenario "A user creates a new article" do
    create_valid_article
    expect_article_displayed
  end

  scenario "A user fails to create a new article" do
    create_invalid_article
    expect_invalid_article_errors_displayed
  end

  def expect_article_displayed
    expect(page).to have_content("Article has been created")
    expect(page.current_path).to eq(articles_path)
    expect(page).to have_content("Created by: #{@john.email}")
  end

  def expect_invalid_article_errors_displayed
    expect(page).to have_content("Article has not been created")
    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content("Body can't be blank")
  end

  def create_valid_article
    goto_create_article
    fill_in "Title", with: "Creating first article"
    fill_in "Body", with: "Lorem Ipsum"
    click_button "Create Article"
  end

  def create_invalid_article
    goto_create_article
    fill_in "Title", with: ""
    fill_in "Body", with: ""
    click_button "Create Article"
  end

  def goto_create_article
    visit "/"
    click_link "New Article"
  end

end