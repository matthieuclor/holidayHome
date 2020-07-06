# frozen_string_literal: true

require 'test_helper'

class FamilyTest < ActiveSupport::TestCase
  test "should save family with all attributes" do
    family = build(:family_with_dependencies)
    assert family.save
  end

  %i(creator name).each do |attibute|
    test "should not save family without #{attibute}" do
      family = build(:family_with_dependencies)
      family.send("#{attibute}=", nil)
      assert_not family.save
    end
  end
end
