# frozen_string_literal: true

require 'test_helper'

class FamilyTest < ActiveSupport::TestCase
  def setup
    @family = families(:clor)
  end

  test 'valid family' do
    assert @family.valid?
  end

  %i(creator name).each do |attibute|
    test "invalid family without #{attibute}" do
      @family.send("#{attibute}=", nil)
      assert_not @family.valid?
      assert_not_nil @family.errors[attibute]
    end
  end

  test 'invalid family with the wrong days for approval' do
    @family.days_for_approval = Family::MAX_DAYS_FOR_APPROVAL + 1
    assert_not @family.valid?
    assert_not_nil @family.errors[:days_for_approval]
  end

  test 'invalid family when i create second family' do
    family = build(
      :family,
      name: 'Second',
      days_for_approval: 10,
      creator: @family.creator
    )

    assert_not family.valid?
    assert family.errors[:base].present?
  end

  test 'valid family when user is premium' do
    deadline = Date.current + 1.year
    @family.creator.update(plan: :premium, plan_deadline: deadline)

    family = build(
      :family,
      name: 'Premium',
      days_for_approval: 15,
      creator: @family.creator
    )

    assert family.valid?
    assert family.basic?
    assert_nil family.plan_deadline
    assert_not family.errors[:base].present?
  end
end
