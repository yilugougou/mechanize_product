require "application_system_test_case"

class TranslatesTest < ApplicationSystemTestCase
  setup do
    @translate = translates(:one)
  end

  test "visiting the index" do
    visit translates_url
    assert_selector "h1", text: "Translates"
  end

  test "creating a Translate" do
    visit translates_url
    click_on "New Translate"

    fill_in "Q", with: @translate.q
    fill_in "Text", with: @translate.text
    fill_in "Tl", with: @translate.tl
    click_on "Create Translate"

    assert_text "Translate was successfully created"
    click_on "Back"
  end

  test "updating a Translate" do
    visit translates_url
    click_on "Edit", match: :first

    fill_in "Q", with: @translate.q
    fill_in "Text", with: @translate.text
    fill_in "Tl", with: @translate.tl
    click_on "Update Translate"

    assert_text "Translate was successfully updated"
    click_on "Back"
  end

  test "destroying a Translate" do
    visit translates_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Translate was successfully destroyed"
  end
end
