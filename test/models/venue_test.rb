# frozen_string_literal: true

require 'test_helper'

class VenueTest < ActiveSupport::TestCase
  def setup
    @venue = venues(:la_tania)
  end

  test 'valid venue' do
    assert @venue.valid?
  end

  test 'valid venue with dependencies' do
    @venue.keys << create(:key, { owner: @venue.creator, venue: @venue })
    @venue.networks << create(:network, { venue: @venue })
    @venue.digital_codes << create(:digital_code, { venue: @venue })
    @venue.home_services << create(:home_service, { venue: @venue })

    assert @venue.valid?
  end

  test 'update venues count on venue family' do
    @venue.creator.update(plan: :premium, plan_deadline: (Date.current + 1.year))
    create(:venue, { family: @venue.family, creator: @venue.creator })
    assert_equal @venue.family.venues_count, 2
  end

  %i(name address creator family bathrooms_count single_beds_count double_beds_count
     baby_beds_count single_sofa_beds_count double_sofa_beds_count).each do |attibute|
    test "invalid venue without #{attibute}" do
      @venue.send("#{attibute}=", nil)
      assert_not @venue.valid?
      assert_not_nil @venue.errors[attibute]
    end
  end

  %i(with_network with_digital_code editable_for_others with_home_service
     with_washing_machine with_tumble_dryer with_dishwasher).each do |attibute|
    test "invalid venue with wrong value on #{attibute}" do
      @venue.send("#{attibute}=", nil)
      assert_not @venue.valid?
      assert_not_nil @venue.errors[attibute]
    end
  end

  test 'invalid venue with duplicate name on family' do
    @venue.creator.update(plan: :premium, plan_deadline: (Date.current + 1.year))
    venue = build(:venue, { family: @venue.family, name: @venue.name, creator: @venue.creator })
    assert_not venue.valid?
    assert venue.errors[:name].present?
  end

  test 'invalid second venue with basic plan' do
    @user = users(:alex)
    create(:venue, { family: @user.families.first, creator: @user })
    venue = build(:venue, { family: @user.families.first, creator: @user })
    assert_not venue.valid?
    assert venue.errors[:base].present?
  end

  test 'invalid venue with basic plan when family is not the first' do
    venue = build(:venue, { family: families(:bouhours), creator: users(:sophie) })
    assert_not venue.valid?
    assert venue.errors[:base].present?
  end

  test 'valid second venue with premium plan' do
    @user = users(:alex)
    @user.update(plan: :premium, plan_deadline: (Date.current + 1.year))
    @user.reload
    create(:venue, { family: @user.families.first, creator: @user })
    venue = build(:venue, { family: @user.families.first, creator: @user })
    assert venue.valid?
    assert_not venue.errors[:base].present?
  end

  test 'valid first venue with basic plan' do
    venue = build(:venue, { family: families(:bouhours), creator: users(:alex) })
    assert venue.valid?
    assert_not venue.errors[:base].present?
  end

  test 'destroy nested objects when user set to false with nested object' do
    assert @venue.with_network
    assert @venue.with_digital_code
    assert @venue.with_home_service

    assert_not_empty @venue.networks
    assert_not_empty @venue.digital_codes
    assert_not_empty @venue.home_services

    @venue.update(
      with_network: false,
      with_digital_code: false,
      with_home_service: false
    )

    assert_not @venue.with_network
    assert_not @venue.with_digital_code
    assert_not @venue.with_home_service

    assert_empty @venue.networks
    assert_empty @venue.digital_codes
    assert_empty @venue.home_services
  end
end
