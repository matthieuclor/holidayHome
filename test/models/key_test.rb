require 'test_helper'

class KeyTest < ActiveSupport::TestCase
  setup do
    @venue = create(:venue_with_dependencies)
  end

  test "should save key with all attributes" do
    key = build(:key_with_dependencies, { venue: @venue })
    assert key.save
  end

  %i(name owner venue).each do |attibute|
    test "should not save key without #{attibute}" do
      key = build(:key_with_dependencies, { venue: @venue })
      key.send("#{attibute}=", nil)
      assert_not key.save
    end
  end

  test "should not save key with the same name of other venue key" do
    first_key = create(:key_with_dependencies, { venue: @venue })
    second_key = build(:key_with_dependencies, {
      venue: first_key.venue,
      name: first_key.name
    })

    assert_not second_key.save
  end
end
