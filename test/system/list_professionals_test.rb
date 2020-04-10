require 'application_system_test_case'

class ListProfessionalsTest < ApplicationSystemTestCase
  test 'root page lists professionals' do
    visit root_url
    assert_selector 'header h1', text: 'Catalyst Inc.'
  end

  test 'anon visiting the index views the header' do
    visit root_url
    within 'header' do
      assert_selector 'h1', text: 'Catalyst Inc.'
      assert_content '+31 6 12345678'
      assert_link 'https://cataly.st'

      assert_link 'Schedule an Appointment', href: 'http://example.com/contact'
    end
  end
end
