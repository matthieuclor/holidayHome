require 'test_helper'

class HomeServiceTest < ActiveSupport::TestCase
  setup do
    @venue = create(:venue_with_dependencies)
  end

  test "should save home service with all attributes" do
    home_service = build(:home_service, { venue: @venue })
    assert home_service.save
  end

  %i(name person_in_charge venue).each do |attibute|
    test "should not save home service without #{attibute}" do
      home_service = build(:home_service, { venue: @venue })
      home_service.send("#{attibute}=", nil)
      assert_not home_service.save
    end
  end

  test "should not save home service with the same name of other venue home service" do
    first_home_service = create(:home_service, { venue: @venue })
    second_home_service = build(:home_service, {
      venue: first_home_service.venue,
      name: first_home_service.name
    })

    assert_not second_home_service.save
  end

  test "should not save home service with wrong email format" do
    home_service = build(:home_service, { venue: @venue, email: "wrongemail" })
    assert_not home_service.save
  end

  test "should create json home service with jbuilder" do
    home_service = create(:home_service, { venue: @venue })
    json_home_service = home_service.to_builder.target!
    assert ActiveSupport::JSON.decode(json_home_service)["id"] == home_service.id
  end
end
