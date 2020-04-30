# frozen_string_literal: true

require 'test_helper'

class Profile::ContactDetailTest < ActiveSupport::TestCase
  test '#contact_details with proper object is valid' do
    subject(key: 'k', value: 'v', type: 't').valid?
    assert_empty subject.errors[:contact_details]
  end

  test '#contact_details must be key, value, type objects each with a string' do
    msg = "can't be blank"
    refute subject(value: 'v', type: 't').valid?
    assert_includes subject.errors[:key], msg

    refute subject(key: 'k', type: 't').valid?
    assert_includes subject.errors[:value], msg

    refute subject(key: 'k', value: 'v').valid?
    assert_includes subject.errors[:type], msg
  end

  test 'key may never be larger than 100 characters' do
    refute subject(key: 'x' * 101).valid?
    assert_includes subject.errors[:key],
                    'is too long (maximum is 100 characters)'
  end

  test 'value may never be larger than 300 characters' do
    refute subject(value: 'x' * 301).valid?
    assert_includes subject.errors[:value],
                    'is too long (maximum is 300 characters)'
  end

  test 'type can only be of whitelist' do
    whitelist = %w[email phone twitter facebook linkedin address]
    whitelist.each do |valid_type|
      subject(type: valid_type).valid?
      refute_includes subject.errors[:type],
                      'is not included in the list'
    end

    refute subject(type: :geocities).valid?
    assert_includes subject.errors[:type],
                    'is not included in the list'
  end

  private

  def subject(attributes = nil)
    if attributes
      @subject = Profile::ContactDetail.new(attributes)
    else
      @subject
    end
  end
end
