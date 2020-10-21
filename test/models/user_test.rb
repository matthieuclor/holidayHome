# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:matthieu)
  end

  test "valid user" do
    assert @user.valid?
  end

  %i(first_name last_name email plan_deadline).each do |attibute|
    test "invalid user without #{attibute}" do
      @user.send("#{attibute}=", nil)
      assert_not @user.valid?
      assert_not_nil @user.errors[attibute]
    end
  end

  test "default user status must be activated" do
    assert @user.activated?
  end

  test "invalid user with the wrong email format" do
    @user.email = 'test.test.com'
    assert_not @user.valid?
    assert_not_nil @user.errors[:email]
  end

  test "invalid user with exsting email" do
    user = build(:user, { email: @user.email })
    assert_not user.valid?
    assert_not_nil user.errors[:email]
  end

  test "invalid user with the wrong password length" do
    @user.password = '1234567'
    assert_not @user.valid?
    assert_not_nil @user.errors[:password]
  end

  test "capitalize first name before save" do
    @user.first_name = "test"
    @user.save
    assert_equal @user.first_name, "Test"
  end

  test "capitalize last name before save" do
    @user.last_name = "test"
    @user.save
    assert_equal @user.last_name, "Test"
  end
end
