# frozen_string_literal: true

require 'test_helper'

class FamilyLinkTest < ActiveSupport::TestCase
  def setup
    @family_link = family_links(:matthieu_clor)
  end

  test "valid family link" do
    assert @family_link.valid?
  end

  %i(family user).each do |attibute|
    test "should not save family_link without #{attibute}" do
      @family_link.send("#{attibute}=", nil)
      assert_not @family_link.valid?
      assert_not_nil @family_link.errors[attibute]
    end
  end

  test "update family when family link is created with a premium user" do
    deadline = Date.current + 1.year
    users(:matthieu).update(plan: :premium, plan_deadline: deadline)
    @user = users(:christian)
    @family = families(:clor)
    @family_link = create(:family_link, { user: @user, family: @family })

    assert @family.premium?
    assert_equal @family.plan_deadline, deadline
  end
end
