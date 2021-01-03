# frozen_string_literal: true

require 'test_helper'

class VehicleTypeTest < ActiveSupport::TestCase
  def setup
    @vehicle_type = vehicle_types(:bicycle)
  end

  test 'valid vehicle type' do
    assert @vehicle_type.valid?
  end

  %i(name icon_prefix).each do |attibute|
    test "invalid vehicle type without #{attibute}" do
      @vehicle_type.send("#{attibute}=", nil)
      assert_not @vehicle_type.valid?
      assert_not_nil @vehicle_type.errors[attibute]
    end
  end

  test 'invalid vehicle with wrong value on icon_prefix' do
    @vehicle_type.icon_prefix = nil
    assert_not @vehicle_type.valid?
    assert_not_nil @vehicle_type.errors[:icon_prefix]
  end

  test 'invalid vehicle with wrong format of icon class' do
    vehicle_type = build(:vehicle_type, { icon_class: 'test' })
    assert_not vehicle_type.valid?
    assert vehicle_type.errors[:icon_class].present?
  end

  test 'valid vehicle without icon class' do
    vehicle_type = build(:vehicle_type, { icon_class: nil })
    assert vehicle_type.valid?
  end

  test 'invalid vehicle with duplicate name' do
    vehicle_type = build(:vehicle_type, { name: 'Vélo' })
    assert_not vehicle_type.valid?
    assert vehicle_type.errors[:name].present?
  end

  test 'should capitalize name before save' do
    vehicle_type = create(:vehicle_type, { name: 'camion' })
    assert_equal vehicle_type.name, 'Camion'
  end
end
