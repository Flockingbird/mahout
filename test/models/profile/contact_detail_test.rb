require 'test_helper'

class Profile::ContactDetailTest < ActiveSupport::TestCase
  test "#contact_details with proper object is valid" do
    subject(key: 'k', value: 'v', type: 't').valid?
    assert_empty subject.errors[:contact_details]
  end

  test "#contact_details must be key, value, type objects each with a string" do
    msg = "can't be blank"
    refute subject(value: 'v', type: 't').valid?
    assert_includes subject.errors[:key], msg

    refute subject(key: 'k', type: 't').valid?
    assert_includes subject.errors[:value], msg

    refute subject(key: 'k', value: 'v').valid?
    assert_includes subject.errors[:type], msg
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
