# frozen_string_literal: true

require 'application_system_test_case'
require 'ogp' # For parsing OG tags

class ListProfessionalsTest < ApplicationSystemTestCase
  setup do
    Workflows::ProfileCreator.new(fixtures: %i[harry ron]).call
  end

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

  # As a participant, when I have a profile, then I want to move to the top
  # when I am more active than others, so that I can present myself at the top.
  #
  # As a catalyst, when visitors land on the professionals index, then I want
  # more active professionals to be more visible than less active
  # professionals, so that I can reward use of the platform.
  #
  # As Physalia Sales, when we sell the platform, then we want to reward active
  # participants with more visibility, so that we  can nudge participants to
  # use the platform more often.
  test 'anon visiting the index sees profiles ordered by last active' do
    # TODO: once we have the first "activity", use that to bump the attribute.
    # For now, depend on fixtures.
    visit root_url
    # Simply assert that Ron Weasly comes first
    assert_text(/Ron Weasly.*Harry Potter/m)
  end

  test 'anon visits page 2 of an index with 22 professionals' do
    Workflows::ProfileImporter.new(count: 20).call
    assert_equal 22, Profile.count # Together with fixtures, should be 21
    visit root_url
    click_link '2'
    # We have 21 items per page (7 rows of 3), so page 2 has one.
    assert_selector('div.card', count: 1)
  end

  # As a catalyst, when I share the link to the professionals on social media,
  # then a card is rendered with a name, url, logo and title. So that
  # others see a nice preview.
  test 'link is shared on social media with og-tag support' do
    visit root_url

    assert_equal 'Professionals at Catalyst Inc.', page.title

    open_graph = OGP::OpenGraph.new(page.html)
    assert_equal 'Professionals at Catalyst Inc.', open_graph.title
    assert_equal 'website', open_graph.type
    assert_match(/catalyst_logo-.*\.png/, open_graph.image.url)
    assert_equal page.current_url, open_graph.url
  end
end
