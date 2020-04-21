require 'test_helper'

class BeddingTest < ActiveSupport::TestCase
  setup do
    @venue = create(:venue_with_dependencies)
    @bedroom = create(:bedroom, venue: @venue)
  end

  test "should save bedding with all attributes" do
    bedding = build(:bedding, { bedroom: @bedroom })
    assert bedding.save
  end

  %i(bed_type bed_count bedroom).each do |attibute|
    test "should not save bedding without #{attibute}" do
      bedding = build(:bedding, { bedroom: @bedroom })
      bedding.send("#{attibute}=", nil)
      assert_not bedding.save
    end
  end

  test "should not save bedding with wrong bed type" do
    bedding = build(:bedding, { bedroom: @bedroom, bed_type: nil })
    assert_not bedding.save
  end

  test "should not save bedding with the same name of other venue bedding" do
    first_bedding = create(:bedding, { bedroom: @bedroom })
    second_bedding = build(:bedding, {
      bedroom: first_bedding.bedroom,
      bed_type: first_bedding.bed_type
    })

    assert_not second_bedding.save
  end

  test "should create json bedding with jbuilder" do
    bedding = create(:bedding, { bedroom: @bedroom })
    json_bedding = bedding.to_builder.target!
    assert ActiveSupport::JSON.decode(json_bedding)["id"] == bedding.id
  end
end
