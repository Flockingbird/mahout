# frozen_string_literal: true

require 'test_helper'

class Profile
  class ContactDetailTest < ActiveSupport::TestCase
    test '#contact_details with proper object is valid' do
      subject(key: 'k', value: 'v', type: 't').valid?
      assert_empty subject.errors[:contact_details]
    end

    test '#contact_details must have key, value, type with a string' do
      msg = "can't be blank"
      assert_not subject(value: 'v', type: 't').valid?
      assert_includes subject.errors[:key], msg

      assert_not subject(key: 'k', type: 't').valid?
      assert_includes subject.errors[:value], msg

      assert_not subject(key: 'k', value: 'v').valid?
      assert_includes subject.errors[:type], msg
    end

    test 'key may never be larger than 100 characters' do
      assert_not subject(key: 'x' * 101).valid?
      assert_includes subject.errors[:key],
                      'is too long (maximum is 100 characters)'
    end

    test 'value may never be larger than 300 characters' do
      assert_not subject(value: 'x' * 301).valid?
      assert_includes subject.errors[:value],
                      'is too long (maximum is 300 characters)'
    end

    test 'type can only be of whitelist' do
      whitelist = %w[email phone twitter facebook linkedin address]
      whitelist.each do |valid_type|
        subject(type: valid_type).valid?
        assert_not_includes subject.errors[:type],
                            'is not included in the list'
      end

      assert_not subject(type: :geocities).valid?
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
end
