require "application_system_test_case"

class ListProfessionalsTest < ApplicationSystemTestCase
  test "visiting the index" do
    visit professionals_url
    assert_selector "h1", text: "Professionals"
  end
end
