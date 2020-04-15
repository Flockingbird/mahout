# As **catalyst of a business network**, when I buy a (trial of) mahout, then I
# can fill it with details from my participants, so that I can showcase my
# participants.
require 'application_system_test_case'

class ViewProfessionalTest < ApplicationSystemTestCase
  test 'anon visits a profile detail page' do
    visit root_url
    click_link "Harry Potter"

    assert_content 'Little Whinging'
    assert_content 'Ministry of Magic'
    assert_link 'http://ministry.gov.wz'
    assert_content 'Had some beef with a snakey guy,'\
                   ' now proud father and civil servant'
  end
end
