# frozen_string_literal: true

require 'test_helper'

class FamilyTest < ActiveSupport::TestCase
  def setup
    @family = families(:clor)
  end

  test "valid family" do
    assert @family.valid?
  end

  %i(creator name).each do |attibute|
    test "invalid family without #{attibute}" do
      @family.send("#{attibute}=", nil)
      assert_not @family.valid?
      assert_not_nil @family.errors[attibute]
    end
  end

  test "invalid family with the wrong days for approval" do
    @family.days_for_approval = Family::MAX_DAYS_FOR_APPROVAL + 1
    assert_not @family.valid?
    assert_not_nil @family.errors[:days_for_approval]
  end
end
