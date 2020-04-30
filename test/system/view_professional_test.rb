# As **catalyst of a business network**, when I buy a (trial of) mahout, then I
# can fill it with details from my participants, so that I can showcase my
# participants.
require 'application_system_test_case'

class ViewProfessionalTest < ApplicationSystemTestCase
  setup do
    Workflows::ProfileCreator.new(fixtures: [:harry, :ron]).call
  end

  test 'anon visits a profile detail page' do
    visit root_url
    click_link "Harry Potter"

    assert_content 'Little Whinging'
    assert_content 'Ministry of Magic'
    assert_link 'http://ministry.gov.wz'
    assert_content 'Had some beef with a snakey guy,'\
                   ' now proud father and civil servant'
  end

  test 'anon views a contact info on a profile detail page' do
    visit root_url
    click_link "Harry Potter"

    within "table#contact" do
      assert_content 'Home +420 (252) 658-3548'
      assert_content 'Work 773-384-0939'
      assert_link 'h.potter@ministry.gov.wz'
      assert_link 'scarface@wmail.wz'
    end
  end

  test 'anon follows a friendly link to a profile page' do
    Workflows::ProfileCreator.new(collection_attributes: [
      { name: 'Patel', location: 'London' },
      { name: 'Patel', location: 'Dublin' }
    ]).call
    visit root_url
    patels = all('a', text: 'Patel')
    assert_match %r{.*/professionals/patel-dublin$}, patels.first[:href]
    assert_match %r{.*/professionals/patel$}, patels.last[:href]
  end

  test 'anon views catalyst details in sidebar' do
    visit root_url
    click_link "Harry Potter"

    assert_no_selector 'header.jumbotron' # ensure we don't have jumbotron
    within ".sidebar.catalyst" do
      assert_selector 'h1', text: 'Catalyst Inc.'
      assert_content '+31 6 12345678'
      assert_link 'https://cataly.st'

      assert_link 'Schedule an Appointment', href: 'http://example.com/contact'
    end
  end
end
