require 'test_helper'

class BathroomTest < ActiveSupport::TestCase
  setup do
    @venue = create(:venue_with_dependencies)
  end

  test "should save bathroom with all attributes" do
    bathroom = build(:bathroom, { venue: @venue })
    assert bathroom.save
    assert @venue.bathrooms_count == 1
  end

  %i(name venue).each do |attibute|
    test "should not save bathroom without #{attibute}" do
      bathroom = build(:bathroom, { venue: @venue })
      bathroom.send("#{attibute}=", nil)
      assert_not bathroom.save
    end
  end

  test "should not save bathroom with the same name of other venue bathroom" do
    first_bathroom = create(:bathroom, { venue: @venue })
    second_bathroom = build(:bathroom, {
      venue: first_bathroom.venue,
      name: first_bathroom.name
    })

    assert_not second_bathroom.save
  end

  test "should create json bathroom with jbuilder" do
    bathroom = create(:bathroom, { venue: @venue })
    json_bathroom = bathroom.to_builder.target!
    assert ActiveSupport::JSON.decode(json_bathroom)["id"] == bathroom.id
  end
end
