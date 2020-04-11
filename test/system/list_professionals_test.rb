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

  test 'anon visiting the index views professionals' do
    visit root_url
    
    assert_selector('div.card', count: 2)
    within 'div.container>div.row' do
      assert_selector 'h4.card-title', text: 'Harry Potter'
      assert_content 'Little Whinging'
      assert_content 'Ministry of Magic'
      assert_link 'http://ministry.gov.wz'
      assert_content 'Had some beef with a snakey guy,'
    end
  end
end
