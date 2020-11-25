# frozen_string_literal: true

require 'test_helper'

class AdminTest < ActiveSupport::TestCase
  def setup
    @admin = admins(:matthieu_admin)
  end

  test 'valid admin' do
    assert @admin.valid?
  end

  %i(first_name last_name email).each do |attibute|
    test "invalid admin without #{attibute}" do
      @admin.send("#{attibute}=", nil)
      assert_not @admin.valid?
      assert_not_nil @admin.errors[attibute]
    end
  end

  test 'invalid admin with the wrong email format' do
    @admin.email = 'test.test.com'
    assert_not @admin.valid?
    assert_not_nil @admin.errors[:email]
  end

  test 'invalid admin with exsting email' do
    admin = build(:admin, { email: @admin.email })
    assert_not admin.valid?
    assert_not_nil admin.errors[:email]
  end

  test 'invalid admin with the wrong password length' do
    @admin.password = '1234567'
    assert_not @admin.valid?
    assert_not_nil @admin.errors[:password]
  end
end
