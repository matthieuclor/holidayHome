# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:matthieu)
  end

  test "valid user" do
    assert @user.valid?
  end

  %i(first_name last_name email).each do |attibute|
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

  test "update all families except when other premium users are present" do
    @olivia = users(:olivia)
    deadline = Date.current + 1.year

    @user.update(plan: :premium, plan_deadline: deadline)
    @user.reload.families.each do |family|
      assert family.premium?
      assert_equal family.plan_deadline, deadline
    end

    @olivia.update(plan: :premium, plan_deadline: deadline)
    @olivia.reload.families.each do |family|
      assert family.premium?
      assert_equal family.plan_deadline, deadline
    end

    @user.basic!

    @user.reload.families.each do |family|
      if family.users.include?(@olivia)
        assert family.premium?
        assert_equal family.plan_deadline, deadline
      else
        assert family.basic?
        assert_nil family.plan_deadline
      end
    end
  end
end
