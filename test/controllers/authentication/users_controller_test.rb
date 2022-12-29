require "test_helper"

class Authentication::UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should create an user" do
    assert_difference("User.count") do
      post users_path, params: {
                         user: {
                           email: 'testme@testme.com',
                           username: 'testme',
                           password: 'testme'
                         }
                       }
    end
    assert_redirected_to products_path
  end
end
