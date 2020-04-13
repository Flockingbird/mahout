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
end
