require 'test_helper'

class ProfileTest < ActiveSupport::TestCase
  test "#by_activity sorts last active top" do
    assert_equal(['Ron Weasly', 'Harry Potter'], 
                Profile.by_activity.pluck(:name))
  end

  test "sets last_activity_at to created_at on initialize" do
    p = Profile.create
    assert_equal p.created_at, p.last_activity_at
  end

  test "#contact_details with proper object is valid" do
    subject = Profile.new(contact_details: [{key: 'k', value: 'v', type: 't'}])
    subject.valid?
    assert_empty subject.errors[:contact_details]
  end

  test "#contact_details must be an array" do
    subject = Profile.new(contact_details: { key: 'k', value: 'v', type: 't' })
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

  test "#contact_details must be key, value, type objects" do
    invalid_items = [
      { value: 'v', type: 't' },
      { key: 'k', type: 't' },
      { key: 'k', value: 'v' }
    ]
    invalid_items.each do |invalid_item|
      subject = Profile.new(contact_details: [invalid_item])
      refute subject.valid?
      assert_includes subject.errors[:contact_details], "is formatted wrong"
    end
  end

  test "#contact_details must have key, value, type set" do
    invalid_items = [
      { key: '', value: 'v', type: 't' },
      { key: 'k', value: '', type: 't' },
      { key: 'k', value: 'v', type: '' },
      { key: ' ', value: 'v', type: 't' },
      { key: "\n", value: 'v', type: 't' },
      { key: nil, value: 'v', type: 't' },
    ]
    invalid_items.each do |invalid_item|
      subject = Profile.new(contact_details: [invalid_item])
      refute subject.valid?
      assert_includes subject.errors[:contact_details], "is formatted wrong"
    end
  end
end
