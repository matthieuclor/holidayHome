require 'test_helper'

class HomeServiceTest < ActiveSupport::TestCase
  setup do
    @home_service = home_services(:home_service)
  end

  test "valid home service" do
    assert @home_service.valid?
  end

  %i(name person_in_charge venue).each do |attibute|
    test "invalid home service without #{attibute}" do
      @home_service.send("#{attibute}=", nil)
      assert_not @home_service.valid?
      assert_not_nil @home_service.errors[attibute]
    end
  end

  test "invalid home service with duplicate name on venue" do
    home_service = build(:home_service, {
      venue: @home_service.venue,
      name: @home_service.name
    })

    assert_not home_service.valid?
    assert_not_nil home_service.errors[:name]
  end

  test "invalid home service with wrong email format" do
    @home_service.email = "wrongemail"
    assert_not @home_service.valid?
    assert_not_nil @home_service.errors[:email]
  end

  test "destroy home services when venue destroyed" do
    venue = @home_service.venue
    assert venue.destroy
    assert_empty HomeService.where(venue_id: venue.id)
  end
end
