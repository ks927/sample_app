require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
    
  def setup
     @user = users(:michael) 
  end
  
  test "login with invalid information" do
     get login_path
     assert_template 'sessions/new'
     post login_path, params: { session: { email: "", password: "" } }
     assert_template 'sessions/new'
     assert_not flash.empty?
     get root_path
     assert flash.empty?
  end
    
  test "login with valid information followed by logout" do
     get login_path
     post login_path, params: { session: { email: @user.email, password: 'password' } }
     assert is_logged_in?
     assert_redirected_to @user # checks the right redirect
     follow_redirect! # actually follows the redirect
     assert_template 'users/show'
     assert_select "a[href=?]", login_path, count: 0 # verifies login link disappears
     assert_select "a[href=?]", logout_path # verifies logout link appears
     assert_select "a[href=?]", user_path(@user)
     delete logout_path # disappears after logout
     assert_not is_logged_in?
     assert_redirected_to root_url
     follow_redirect!
     assert_select "a[href=?]", login_path # login link reappears
     assert_select "a[href=?]", logout_path, count: 0 # verifies logout link disappears
     assert_select "a[href=?]", user_path(@user), count: 0 # verifies user_path disappears
  end
    
end
