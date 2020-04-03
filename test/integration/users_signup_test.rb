require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
   test "the truth" do
     assert true
   end
  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { username:  "Example User",
                                         email: "user@example.com",
                                         password:              "password",
                                         password_confirmation: "password",
                                         firstname: "test firstname",
                                         lastname: "test lastname",
                                         gender: "male",
                                         occupation: "Brandeis",
                                         age: 12} }
    end
    assert_redirected_to root_url
    assert is_logged_in?
  end
end
