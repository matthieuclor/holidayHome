# frozen_string_literal: true

require 'test_helper'

class FamilyLinkTest < ActiveSupport::TestCase
  test "should save family_link with all attributes" do
    family_link = build(:family_link)
    assert family_link.save
  end

  %i(user family).each do |attibute|
    test "should not save family_link without #{attibute}" do
      family_link = build(:family_link, { attibute => nil })
      assert_not family_link.save
    end
  end
end
