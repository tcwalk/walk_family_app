require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post signup_path, params: { user: { name:  "",
                                         email: "user@invalid",
                                         password:              "foo",
                                         password_confirmation: "bar" } }
    end

    assert_template 'users/new'
#    assert_response :success
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'

    assert_select 'form[action="/signup"]'

    assert_select 'div.alert'
    assert_select 'div.field_with_errors'
    assert_select 'div' '#' "error_explanation"
    assert_select 'div.alert-danger'
    assert_select "div", {:text=>"The form contains 4 errors."}
    assert_select "ul li", {:text=>"Name can't be blank"}
    assert_select "ul li", {:text=>"Email is invalid"}
    assert_select "ul li", {:text=>"Password confirmation doesn't match Password"}
    assert_select "ul li", {:text=>"Password is too short (minimum is 6 characters)"}
#    assert_select "div.field_with_errors", {:count=>8}

  end

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name:  "Example User",
                                         email: "user@example.com",
                                         password:              "password",
                                         password_confirmation: "password" } }
    end
    follow_redirect!
    assert_template 'users/show'
    assert_not flash.nil?
    assert is_logged_in?

  end

end

#error_explanation
#.field_with_errors
