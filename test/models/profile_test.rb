require 'test_helper'
require 'minitest/mock'

class ProfileTest < ActiveSupport::TestCase
  test "#by_activity sorts last active top" do
    assert_equal(['Ron Weasly', 'Harry Potter'], 
                Profile.by_activity.pluck(:name))
  end

  test "sets last_activity_at to created_at on initialize" do
    p = Profile.create
    assert_equal p.created_at, p.last_activity_at
  end

  test "#contact_details is always an array" do
    assert_kind_of Array, Profile.new.contact_details
    assert_kind_of Array, Profile.new(contact_details: []).contact_details
  end

  test "#contact_details is an array of ContactDetail" do
    subject = Profile.new(contact_details: [{key: 'k', value: 'v', type: 't'}])
    assert_kind_of Profile::ContactDetail, subject.contact_details.first
  end

  test "#contact_details with proper object is valid" do
    subject = Profile.new(contact_details: [{key: 'k', value: 'v', type: 't'}])
    subject.valid?
    assert_empty subject.errors[:contact_details]
  end

  test "#contact_details with ContactDetail is valid" do
    subject = Profile.new(contact_details: [
      Profile::ContactDetail.new(key: 'k', value: 'v', type: 't')
    ])
    subject.valid?
    assert_empty subject.errors[:contact_details]
  end

  test "#contact_details must be an array" do
    subject = Profile.new(contact_details: { foo: "bar" })
    refute subject.valid?
    assert_includes subject.errors[:contact_details], "is formatted wrong"
  end

  test "#contact_details is limited to 255 records" do
    contact_details = Array.new(256) do |i|
      { key: "key #{i}", value: "value #{1}", type: "type #{1}" }
    end

    subject = Profile.new(contact_details: contact_details)
    refute subject.valid?
    assert_includes subject.errors[:contact_details],
      "has too many entries (maximum is 255 entries)"
  end

  test "#contact_details each entry must be valid" do
    valid_detail = Minitest::Mock.new
    invalid_detail = Minitest::Mock.new
    valid_detail.expect :valid?, true
    valid_detail.expect :as_json, { key: :value }, [Hash]
    invalid_detail.expect :valid?, false
    invalid_detail.expect :as_json, { key: :value }, [Hash]

    subject = Profile.new(contact_details: [valid_detail, invalid_detail])
    refute subject.valid?
    assert_includes subject.errors[:contact_details], "is formatted wrong"
  end
end
