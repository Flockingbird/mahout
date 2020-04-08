require 'test_helper'

class ProfessionalsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get professionals_url
    assert_response :success
  end
end
