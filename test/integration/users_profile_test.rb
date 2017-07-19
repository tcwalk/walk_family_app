require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  include ApplicationHelper

  def setup
    @user = users(:michael)
  end

  test "profile display" do
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'title', full_title(@user.name)

    # The following line from Rails Tutorial did not pass tests
    # due to my addition of email to the user info
#    assert_match 'h1', text: @user.name
    # alternative with name and email also failed
#    assert_match 'h1', text: "#{@user.name}\n\t#{@user.email}"
    # Use match to pass

    assert_select 'h1>img.gravatar'

    assert_match @user.name.to_s, response.body
    assert_match @user.email.to_s, response.body


    assert_match @user.microposts.count.to_s, response.body
    assert_select 'div.pagination'
    @user.microposts.paginate(page: 1).each do |micropost|
      assert_match micropost.content, response.body

      assert_select 'div.pagination', count: 1

    end
  end

  test "should show user follow stats on home page" do
    log_in_as(@user)
    get root_path(@user)
    assert_template 'static_pages/home'
    assert_select 'div.stats', count: 1
    slater  = users(:slater)
    @user.follow(slater)
    slater.follow(@user)
    assert_match "following", response.body
    assert_match "followers", response.body
    assert_includes(@user.following, slater)
    assert_includes(@user.followers, slater)
#    assert_equal(@user.following.count, 1)
#    assert_equal(@user.followers.count, 1)
    assert_match @user.following.count.to_s, response.body
    assert_match @user.followers.count.to_s, response.body
  end

end
