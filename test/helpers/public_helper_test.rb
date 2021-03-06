# frozen_string_literal: true

require 'test_helper'

class PublicHelperTest < ActionView::TestCase
  test 'content_for :title sets the title' do
    content_for :title, 'The title'
    assert_equal 'The title', title
  end
  test 'content_for :title defaults to empty string' do
    content_for :title, nil
    assert_equal '', title
  end

  test 'content_for :meta_description sets the meta_description' do
    content_for :meta_description, 'The description'
    assert_equal 'The description', meta_description
  end
  test 'content_for :meta_description defaults to empty string' do
    content_for :meta_description, nil
    assert_equal '', meta_description
  end

  test 'simplified_format removes all tags with "sanitize"' do
    text = '<foo/><p>bar</p>'
    assert_equal 'bar', simplified_format(text)
  end

  test 'simplified_format replaces newlines with br tags' do
    text = "hello\nworld"
    assert_equal 'hello<br/>world', simplified_format(text)
  end

  test 'simplified_format ignores repeated newlines' do
    text = "hello\n\n\nworld,\nhow are you?"
    assert_equal 'hello<br/>world,<br/>how are you?', simplified_format(text)
  end

  test 'simplified_format marks html as safe' do
    assert simplified_format('hello').html_safe?
  end

  test 'formatted_contact_detail_value with email is mailto link' do
    cd = contact_detail(value: 'm@example.com', type: 'email')
    assert_equal '<span itemprop="email">'\
                 '<a href="mailto:m@example.com">m@example.com</a></span>',
                 formatted_contact_detail_value(cd)
  end
  test 'formatted_contact_detail_value with phone is tel: link' do
    cd = contact_detail(value: '112', type: 'phone')
    assert_equal '<a itemprop="telephone" href="tel:112">112</a>',
                 formatted_contact_detail_value(cd)
  end
  test 'formatted_contact_detail_value with twitter is @value url' do
    cd = contact_detail(value: 'berkes', type: 'twitter')
    assert_equal(
      '<a itemprop="url" href="https://twitter.com/berkes">@berkes</a>',
      formatted_contact_detail_value(cd)
    )
  end
  test 'formatted_contact_detail_value with facebook is value url' do
    cd = contact_detail(value: 'berkes', type: 'facebook')
    assert_equal(
      '<a itemprop="url" href="https://www.facebook.com/berkes">berkes</a>',
      formatted_contact_detail_value(cd)
    )
  end
  test 'formatted_contact_detail_value with linkedin is value url' do
    cd = contact_detail(value: 'berkes', type: 'linkedin')
    assert_equal(
      '<a itemprop="url" href="https://linkedin.com/berkes">berkes</a>',
      formatted_contact_detail_value(cd)
    )
  end
  test 'when unkown or other type, renders normal value' do
    cd = contact_detail(value: 'Kerkstraat 12', type: 'postal')
    assert_equal 'Kerkstraat 12', formatted_contact_detail_value(cd)
  end

  test 'formatted_contact_detail_icon with email is fa-envelope' do
    cd = contact_detail(type: 'email')
    assert_equal '<i class="fas fa-envelope"></i>',
                 formatted_contact_detail_icon(cd)
  end
  test 'formatted_contact_detail_icon with phone is fa-phone and fa-sms' do
    cd = contact_detail(type: 'phone')
    assert_equal '<i class="fas fa-phone"></i><i class="fas fa-sms"></i>',
                 formatted_contact_detail_icon(cd)
  end
  test 'formatted_contact_detail_icon with twitter is fa-twitter' do
    cd = contact_detail(type: 'twitter')
    assert_equal '<i class="fab fa-twitter"></i>',
                 formatted_contact_detail_icon(cd)
  end
  test 'formatted_contact_detail_icon with facebook is fa-facebook' do
    cd = contact_detail(type: 'facebook')
    assert_equal '<i class="fab fa-facebook"></i>',
                 formatted_contact_detail_icon(cd)
  end
  test 'formatted_contact_detail_icon with linkedin is fa-linkedin' do
    cd = contact_detail(type: 'linkedin')
    assert_equal '<i class="fab fa-linkedin"></i>',
                 formatted_contact_detail_icon(cd)
  end

  private

  def contact_detail(key: '', value: '', type: '')
    ProfileViewModel::ContactDetailViewModel.new(
      OpenStruct.new(key: key, value: value, type: type)
    )
  end
end
