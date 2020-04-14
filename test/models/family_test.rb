# frozen_string_literal: true

require 'test_helper'

class FamilyTest < ActiveSupport::TestCase
  test "should save family with all attributes" do
    family = build(:family)
    assert family.save
  end

  test "should not save admin without name" do
    family = build(:family, { name: nil })
    assert_not family.save
  end
end
