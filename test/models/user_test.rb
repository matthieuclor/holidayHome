# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:matthieu)
  end

  test 'valid user' do
    assert @user.valid?
  end

  %i(first_name last_name email current_school_holiday_zones).each do |attibute|
    test "invalid user without #{attibute}" do
      @user.send("#{attibute}=", nil)
      assert_not @user.valid?
      assert_not_nil @user.errors[attibute]
    end
  end

  test 'default user status must be activated' do
    assert @user.activated?
  end

  test 'invalid user with the wrong email format' do
    @user.email = 'test.test.com'
    assert_not @user.valid?
    assert_not_nil @user.errors[:email]
  end

  test 'invalid user with exsting email' do
    user = build(:user, { email: @user.email })
    assert_not user.valid?
    assert_not_nil user.errors[:email]
  end

  test 'invalid user with the wrong password length' do
    @user.password = '1234567'
    assert_not @user.valid?
    assert_not_nil @user.errors[:password]
  end

  test 'invalid user with the wrong zones keys' do
    @user.current_school_holiday_zones =  { 'A': 'false', 'B': 'false', 'D': 'true' }
    assert_not @user.valid?
    assert_not_nil @user.errors[:current_school_holiday_zones]
  end

  test 'invalid user with the wrong zones values' do
    @user.current_school_holiday_zones =  { 'A': 'false', 'B': 'test', 'C': 'true' }
    assert_not @user.valid?
    assert_not_nil @user.errors[:current_school_holiday_zones]
  end

  test 'capitalize first name before save' do
    @user.first_name = 'test'
    @user.save
    assert_equal @user.first_name, 'Test'
  end

  test 'capitalize last name before save' do
    @user.last_name = 'test'
    @user.save
    assert_equal @user.last_name, 'Test'
  end

  test 'update all families except when other premium users are present' do
    @olivia = users(:olivia)
    deadline = Date.current + 1.year
    deadline_max = Date.current + 10.years

    @user.update(plan: :premium, plan_deadline: deadline_max)
    @user.reload.families.each do |family|
      assert family.premium?
      assert_equal family.plan_deadline, deadline_max
    end

    @olivia.update(plan: :premium, plan_deadline: deadline)
    @olivia.reload.families.each do |family|
      assert family.premium?

      if family.users.include?(@user)
        assert_equal family.plan_deadline, deadline_max
      else
        assert_equal family.plan_deadline, deadline
      end
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

  test 'destroy sended invitations when user destroyed' do
    sended_invitations = @user.sended_invitations
    assert sended_invitations.present?
    assert @user.destroy
    assert_empty sended_invitations.reload
  end

  test 'destroy received invitations when user destroyed' do
    received_invitations = @user.received_invitations
    assert received_invitations.present?
    assert @user.destroy
    assert_empty received_invitations.reload
  end

  test 'destroy keys when user destroyed' do
    keys = @user.keys
    assert keys.present?
    assert @user.destroy
    assert_empty keys.reload
  end
end
