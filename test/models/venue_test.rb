require 'test_helper'

class VenueTest < ActiveSupport::TestCase
  test "should save venue with all attributes" do
    venue = build(:venue_with_dependencies)
    assert venue.save
    assert venue.family.venues_count == 1
  end

  test "should save venue with all dependencies" do
    venue = build(:venue_with_dependencies, {
      keys: [build(:key_with_dependencies)],
      networks: [build(:network)],
      digital_codes: [build(:digital_code)],
      home_services: [build(:home_service)]
    })

    assert venue.save
  end

  %i(name address creator family bathrooms_count single_beds_count double_beds_count baby_beds_count).each do |attibute|
    test "should not save venue without #{attibute}" do
      venue = build(:venue_with_dependencies)
      venue.send("#{attibute}=", nil)
      assert_not venue.save
    end
  end

  %i(with_network with_digital_code editable_for_others with_home_service).each do |attibute|
    test "should not save venue with wrong value on #{attibute}" do
      venue = build(:venue_with_dependencies, { attibute => nil })
      assert_not venue.save
    end
  end

  test "should not save venue with the same name of other family venue" do
    first_venue = create(:venue_with_dependencies)
    second_venue = build(:venue, {
      family: first_venue.family,
      creator: first_venue.creator,
      name: first_venue.name
    })

    assert_not second_venue.save
  end
end
