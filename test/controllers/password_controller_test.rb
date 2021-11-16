require 'test_helper'

class PasswordControllerTest < ActionDispatch::IntegrationTest
  test "should get forget_password" do
    get password_forget_password_url
    assert_response :success
  end

  test "should get reset_password" do
    get password_reset_password_url
    assert_response :success
  end

end
