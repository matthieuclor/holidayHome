require 'test_helper'

class KeyTest < ActiveSupport::TestCase
  setup do
    @key = keys(:key)
  end

  test "valid key" do
    assert @key.valid?
  end

  %i(name owner venue).each do |attibute|
    test "invalid key without #{attibute}" do
      @key.send("#{attibute}=", nil)
      assert_not @key.valid?
      assert_not_nil @key.errors[attibute]
    end
  end

  test "invalid key with duplicate name on venue" do
    key = build(:key, { venue: @key.venue, name:  @key.name })
    assert_not key.valid?
    assert_not_nil key.errors[:name]
  end

  test "destroy keys when venue destroyed" do
    venue = @key.venue
    assert venue.destroy
    assert_empty Key.where(venue_id: venue.id)
  end
end
