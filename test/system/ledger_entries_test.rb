require "application_system_test_case"

class LedgerEntriesTest < ApplicationSystemTestCase
  setup do
    @ledger_entry = ledger_entries(:one)
  end

  test "visiting the index" do
    visit ledger_entries_url
    assert_selector "h1", text: "Ledger Entries"
  end

  test "creating a Ledger entry" do
    visit ledger_entries_url
    click_on "New Ledger Entry"

    click_on "Create Ledger entry"

    assert_text "Ledger entry was successfully created"
    click_on "Back"
  end

  test "updating a Ledger entry" do
    visit ledger_entries_url
    click_on "Edit", match: :first

    click_on "Update Ledger entry"

    assert_text "Ledger entry was successfully updated"
    click_on "Back"
  end

  test "destroying a Ledger entry" do
    visit ledger_entries_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Ledger entry was successfully destroyed"
  end
end
