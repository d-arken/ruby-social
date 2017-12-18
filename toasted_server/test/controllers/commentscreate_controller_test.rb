require 'test_helper'

class CommentscreateControllerTest < ActionDispatch::IntegrationTest
  test "should get destroy" do
    get commentscreate_destroy_url
    assert_response :success
  end

  test "should get update" do
    get commentscreate_update_url
    assert_response :success
  end

end
