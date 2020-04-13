require 'test_helper'

class ProfileTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "#by_activity sorts last active top" do
    assert_equal(['Ron Weasly', 'Harry Potter'], 
                Profile.by_activity.pluck(:name))
  end

end
