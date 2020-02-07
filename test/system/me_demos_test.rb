require "application_system_test_case"

class MeDemosTest < ApplicationSystemTestCase
  setup do
    @me_demo = me_demos(:one)
  end

  test "visiting the index" do
    visit me_demos_url
    assert_selector "h1", text: "Me Demos"
  end

  test "creating a Me demo" do
    visit me_demos_url
    click_on "New Me Demo"

    fill_in "Me text", with: @me_demo.me_text
    click_on "Create Me demo"

    assert_text "Me demo was successfully created"
    click_on "Back"
  end

  test "updating a Me demo" do
    visit me_demos_url
    click_on "Edit", match: :first

    fill_in "Me text", with: @me_demo.me_text
    click_on "Update Me demo"

    assert_text "Me demo was successfully updated"
    click_on "Back"
  end

  test "destroying a Me demo" do
    visit me_demos_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Me demo was successfully destroyed"
  end
end
