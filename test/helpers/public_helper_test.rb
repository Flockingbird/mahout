require "test_helper"

class PublicHelperTest < ActionView::TestCase
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
    assert_equal '<a href="mailto:m@example.com">m@example.com</a>',
                 formatted_contact_detail_value(cd)
  end
  test 'formatted_contact_detail_value with phone is tel: link' do
    cd = contact_detail(value: '112', type: 'phone')
    assert_equal '<a href="tel:112">112</a>',
                 formatted_contact_detail_value(cd)
  end
  test 'formatted_contact_detail_value with twitter is @value url' do
    cd = contact_detail(value: 'berkes', type: 'twitter')
    assert_equal '<a href="https://twitter.com/berkes">@berkes</a>',
                 formatted_contact_detail_value(cd)
  end
  test 'formatted_contact_detail_value with facebook is value url' do
    cd = contact_detail(value: 'berkes', type: 'facebook')
    assert_equal '<a href="https://www.facebook.com/berkes">berkes</a>',
                 formatted_contact_detail_value(cd)
  end
  test 'formatted_contact_detail_value with linkedin is value url' do
    cd = contact_detail(value: 'berkes', type: 'linkedin')
    assert_equal '<a href="https://linkedin.com/berkes">berkes</a>',
                 formatted_contact_detail_value(cd)
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
    Profile::ContactDetailViewModel.new(OpenStruct.new(key: key, value: value, type: type))
  end
end
