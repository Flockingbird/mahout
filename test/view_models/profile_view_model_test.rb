# frozen_string_literal: true

require 'test_helper'
require 'minitest/mock'

class ProfileViewModelTest < ActiveSupport::TestCase
  test 'it has name, bio, company_name, url, location, header and avatar' do
    subject = ProfileViewModel.new(mock_resource)
    assert_respond_to subject, :name
    assert_respond_to subject, :bio
    assert_respond_to subject, :company_name
    assert_respond_to subject, :url
    assert_respond_to subject, :location
    assert_respond_to subject, :header
    assert_respond_to subject, :avatar
  end

  test 'it has a friendly_id' do
    subject = ProfileViewModel.new(mock_resource)
    assert_respond_to subject, :friendly_id
  end

  test '#avatar_with_fallback with attached avatar' do
    subject = ProfileViewModel.new(mock_resource)

    assert_equal 'avatar.png',
                 subject.avatar_with_fallback(resize_to_fill: [10, 10])
  end

  test '#avatar_with_fallback without attached avatar' do
    subject = ProfileViewModel.new(
      mock_resource(avatar: mock_avatar(attached: false))
    )

    assert_equal 'default_avatar.png',
                 subject.avatar_with_fallback(resize_to_fill: [10, 10])
  end

  private

  def mock_resource(attributes = {})
    with_defaults = {
      avatar: mock_avatar,
      header: nil,
      name: '',
      bio: '',
      company_name: '',
      url: '',
      location: ''
    }.merge(attributes)

    @mock_resource ||= OpenStruct.new(with_defaults)
  end

  def mock_avatar(attached: true)
    mock_avatar = Minitest::Mock.new
    mock_avatar.expect(:variant, 'avatar.png', [Hash]) if attached
    mock_avatar.expect(:attached?, attached)
    mock_avatar
  end
end
