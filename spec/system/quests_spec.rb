require "rails_helper"

describe "Quests", type: :system do
  it "visits the index page" do
    visit root_path
    expect(page).to have_content("Academy Quest")
  end
end
