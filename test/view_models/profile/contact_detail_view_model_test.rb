require 'test_helper'
require 'minitest/mock'

class ProfileContactDetailViewModelTest < ActiveSupport::TestCase
  test 'it has key, value and type' do
    subject = Profile::ContactDetailViewModel.new(mock_resource)
    assert_respond_to subject, :key
    assert_respond_to subject, :value
    assert_respond_to subject, :type
  end

  test 'it symbolizes type' do
    subject = Profile::ContactDetailViewModel.new(
      mock_resource(type: 'the_type')
    )
    assert_equal :the_type, subject.type
  end

  private

  def mock_resource(key: '', value: '', type: '')
    @mock_resource ||= OpenStruct.new(key: key, value: value, type: type)
  end
end
