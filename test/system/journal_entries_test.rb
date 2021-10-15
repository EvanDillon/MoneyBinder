require "application_system_test_case"

class JournalEntriesTest < ApplicationSystemTestCase
  setup do
    @journal_entry = journal_entries(:one)
  end

  test "visiting the index" do
    visit journal_entries_url
    assert_selector "h1", text: "Journal Entries"
  end

  test "creating a Journal entry" do
    visit journal_entries_url
    click_on "New Journal Entry"

    click_on "Create Journal entry"

    assert_text "Journal entry was successfully created"
    click_on "Back"
  end

  test "updating a Journal entry" do
    visit journal_entries_url
    click_on "Edit", match: :first

    click_on "Update Journal entry"

    assert_text "Journal entry was successfully updated"
    click_on "Back"
  end

  test "destroying a Journal entry" do
    visit journal_entries_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Journal entry was successfully destroyed"
  end
end
