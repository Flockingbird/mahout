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
end
