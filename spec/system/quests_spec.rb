require "rails_helper"

describe "Quests", type: :system do
  it "visits the index page" do
    visit root_path
    expect(page).to have_content("My Academy Quest")
  end

  context "when creating a new quest" do
    before do
      visit root_path
    end

    it "shows the button to create a new quest" do
      click_on_new_quest_button
      should_see_new_quest_page
    end

    it "allows users to create a new quest" do
      click_on_new_quest_button
      should_see_new_quest_page
      create_new_quest("Added Test Quest")
      should_see_the_added_quest("Added Test Quest")
    end
  end

  context "when deleting a quest" do
    let!(:quest) { create(:quest, name: "Quest to be deleted") }
    before do
      visit root_path
    end
    it "allows users to delete a quest" do
      click_on_delete_quest_button(quest)
      should_not_see_the_deleted_quest("Quest to be deleted")
    end
  end

  context "when user toggles a quest's completed status via checkbox" do
    let!(:quest) { create(:quest, name: "Quest to be toggled", completed: false) }
    before do
      visit root_path
    end

    it "updates the quest's completed status" do
      toggle_completed_checkbox(quest)
      should_see_updated_quest_status(quest)
    end
  end
end

def click_on_new_quest_button
  click_link id: "new-quest-button"
end

def should_see_new_quest_page
  expect(page).to have_content("New Quest")
  expect(page).to have_current_path(new_quest_path)
end

def create_new_quest(name)
  fill_in id: "quest-name-field", with: "Added Test Quest"
  click_button id: "add-quest-button"
  sleep 0.5
end

def should_see_the_added_quest(name)
  expect(page).to have_content(name)
end

def click_on_delete_quest_button(quest)
  click_button id: "delete-#{quest.id}-button"
end

def should_not_see_the_deleted_quest(name)
  expect(page).not_to have_content(name)
end

def toggle_completed_checkbox(quest)
  find_by_id("quest-#{quest.id}-completed-checkbox").click
  sleep 1
  quest.reload
end

def should_see_updated_quest_status(quest)
  expect(quest.completed).to be_truthy
end
