# frozen_string_literal: true

require 'test_helper'

class AdminTest < ActiveSupport::TestCase
  test "should save admin with all attributes" do
    admin = build(:admin)
    assert admin.save
  end

  %i(first_name last_name email password).each do |attibute|
    test "should not save admin without #{attibute}" do
      admin = build(:admin, { attibute => nil })
      assert_not admin.save
    end
  end

  test "should not save admin with the wrong email format" do
    admin = build(:admin, { email: 'test.test.com' })
    assert_not admin.save
  end

  test "should not save admin with exsting email" do
    create(:admin, { email: 'test@test.com' })
    admin = build(:admin, { email: 'test@test.com' })
    assert_not admin.save
  end

  test "should not save admin with the wrong password length" do
    admin = build(:admin, { password: '1234567' })
    assert_not admin.save
  end
end
