require 'test_helper'

class SessionTest < ActiveSupport::TestCase

  def setup
    @session = Session.new(user_id: 1, remember_digest: "digest")
  end

  test "should be valid" do
    assert @session.valid?
  end

  test "should require a user_id" do
    @session.user_id = nil
    assert_not @session.valid?
  end

  test "should require a remember_digest" do
    @session.remember_digest = nil
    assert_not @session.valid?
  end
end
