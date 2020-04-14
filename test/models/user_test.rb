# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should save user with all attributes" do
    user = build(:user)
    assert user.save
  end

  %i(first_name last_name email password).each do |attibute|
    test "should not save user without #{attibute}" do
      user = build(:user, { attibute => nil })
      assert_not user.save
    end
  end

  test "should not save user with the wrong email format" do
    user = build(:user, { email: 'test.test.com' })
    assert_not user.save
  end

  test "should not save user with exsting email" do
    create(:user, { email: 'test@test.com' })
    user = build(:user, { email: 'test@test.com' })
    assert_not user.save
  end

  test "should not save user with the wrong password length" do
    user = build(:user, { password: '1234567' })
    assert_not user.save
  end
end
