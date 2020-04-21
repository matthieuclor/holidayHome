require 'test_helper'

class DigitalCodeTest < ActiveSupport::TestCase
  setup do
    @venue = create(:venue_with_dependencies)
  end

  test "should save digital code with all attributes" do
    digital_code = build(:digital_code, { venue: @venue })
    assert digital_code.save
  end

  %i(name password venue).each do |attibute|
    test "should not save digital code without #{attibute}" do
      digital_code = build(:digital_code, { venue: @venue })
      digital_code.send("#{attibute}=", nil)
      assert_not digital_code.save
    end
  end

  test "should not save digital code with the same name of other venue digital code" do
    first_digital_code = create(:digital_code, { venue: @venue })
    second_digital_code = build(:digital_code, {
      venue: first_digital_code.venue,
      name: first_digital_code.name
    })

    assert_not second_digital_code.save
  end

  test "should create json digital code with jbuilder" do
    digital_code = create(:digital_code, { venue: @venue })
    json_digital_code = digital_code.to_builder.target!
    assert ActiveSupport::JSON.decode(json_digital_code)["id"] == digital_code.id
  end
end
