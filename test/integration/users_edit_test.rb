require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

	def setup
		@user = users(:michael)	
	end

  test "unsuccessful edit" do
  	log_in_as @user
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), user: { name: "",
    																email: "foo@invalid",
    																password: "foo",
    																password_confirmation: "bar" }
		assert_template 'users/edit'
  end

  test "successful edit" do
  	log_in_as @user
    get edit_user_path(@user)
    assert_template 'users/edit'
    name = "Foo Bar"
    email = "foo@bar.com"
    patch user_path(@user), user: { name: name,
    																email: email,
    																password: "",
    																password_confirmation: "" }
		assert_not flash.empty?
		assert_redirected_to @user
		@user.reload
		assert_equal name, @user.name
		assert_equal email, @user.email
  end

  test "successful edit with friendly forwarding" do
  	get edit_user_path(@user)
  	log_in_as @user
  	assert_redirected_to edit_user_path(@user)
    name = "Foo Bar"
    email = "foo@bar.com"
    patch user_path(@user), user: { name: name,
    																email: email,
    																password: "",
    																password_confirmation: "" }
		assert_not flash.empty?
		assert_redirected_to @user
		@user.reload
		assert_equal name, @user.name
		assert_equal email, @user.email
  end

  test "sessions reset" do
    assert_difference '@user.sessions.count', 1 do
      log_in_as @user
    end
    get edit_user_path(@user)
    # Check sessions layout
    assert_match sessions(:one).ip_address, response.body
    assert_match sessions(:two).ip_address, response.body
    # Forgetting all sessions
    delete reset_path
    assert_redirected_to edit_user_path(@user)
    follow_redirect!
    @user.reload
    assert_equal 0, @user.sessions.count
    assert_match CGI::escapeHTML("No remembred sessions."), response.body
  end
end
