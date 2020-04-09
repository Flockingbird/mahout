require "application_system_test_case"

class ListProfessionalsTest < ApplicationSystemTestCase
  test "root page lists professionals" do
    visit root_url
    assert_selector "header h1", text: "Catalyst Inc."
  end

  test "anon visiting the index views the header" do
    visit root_url
    assert_selector "header h1", text: "Catalyst Inc."
    assert_selector "header", text: "+31 6 12345678"
    assert_selector "header a", text: "https://cataly.st"
    assert_selector "header a", text: "Call to action!"
  end
end
