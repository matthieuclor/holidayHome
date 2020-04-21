require 'test_helper'

class BedroomTest < ActiveSupport::TestCase
  setup do
    @venue = create(:venue_with_dependencies)
  end

  test "should save bedroom with all attributes" do
    bedroom = build(:bedroom, { venue: @venue })
    assert bedroom.save
    assert @venue.bedrooms_count == 1
  end

  test "should save bedroom with all dependencies" do
    bedroom = build(:bedroom, { venue: @venue, beddings: [build(:bedding)] })
    assert bedroom.save
  end

  %i(name venue).each do |attibute|
    test "should not save bedroom without #{attibute}" do
      bedroom = build(:bedroom, { venue: @venue })
      bedroom.send("#{attibute}=", nil)
      assert_not bedroom.save
    end
  end

  test "should not save bedroom with the same name of other venue bedroom" do
    first_bedroom = create(:bedroom, { venue: @venue })
    second_bedroom = build(:bedroom, {
      venue: first_bedroom.venue,
      name: first_bedroom.name
    })

    assert_not second_bedroom.save
  end

  test "should create json bedroom with jbuilder" do
    bedroom = create(:bedroom, { venue: @venue })
    json_bedroom = bedroom.to_builder.target!
    assert ActiveSupport::JSON.decode(json_bedroom)["id"] == bedroom.id
  end
end
