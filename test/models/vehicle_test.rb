# frozen_string_literal: true

require 'test_helper'

class VehicleTest < ActiveSupport::TestCase
  def setup
    @vehicle = vehicles(:la_tania_bicycle)
  end

  test 'valid vehicle' do
    assert @vehicle.valid?
  end

  test 'update vehicles count on venue' do
    @venue = venues(:la_tania)
    assert_equal @venue.vehicles_count, 1
    create(:vehicle, { venue: @venue })
    assert_equal @venue.reload.vehicles_count, 2
  end

  %i(vehicle_type name size condition venue_id).each do |attibute|
    test "invalid vehicle without #{attibute}" do
      @vehicle.send("#{attibute}=", nil)
      assert_not @vehicle.valid?
      assert_not_nil @vehicle.errors[attibute]
    end
  end

  %i(size condition).each do |attibute|
    test "invalid vehicle with wrong value on #{attibute}" do
      @vehicle.send("#{attibute}=", nil)
      assert_not @vehicle.valid?
      assert_not_nil @vehicle.errors[attibute]
    end
  end

  test 'invalid vehicle with duplicate name ith same vehicle_type and venue' do
    vehicle = build(
      :vehicle,
      {
        venue: venues(:la_tania),
        name: @vehicle.name,
        vehicle_type: @vehicle.vehicle_type
      }
    )

    assert_not vehicle.valid?
    assert vehicle.errors[:name].present?
  end

  test 'should capitalize vehicle type and name before save' do
    vehicle = create(
      :vehicle,
      {
        venue: venues(:la_tania),
        name: 'vélo test',
        vehicle_type: 'vélo'
      }
    )

    assert_equal vehicle.name, 'Vélo test'
    assert_equal vehicle.vehicle_type, 'Vélo'
  end

  test 'should destroy vehicle when when the depend venue is destroyed' do
    @venue = venues(:la_tania)
    assert_equal Vehicle.where(venue: @venue).count, 1
    @venue.destroy
    assert_equal Vehicle.where(venue: @venue).count, 0
  end
end
