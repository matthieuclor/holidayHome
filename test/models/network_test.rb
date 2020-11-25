# frozen_string_literal: true

require 'test_helper'

class NetworkTest < ActiveSupport::TestCase
  setup do
    @network = networks(:network)
  end

  test 'valid network' do
    assert @network.valid?
  end

  %i(name venue).each do |attibute|
    test "invalid network without #{attibute}" do
      @network.send("#{attibute}=", nil)
      assert_not @network.valid?
      assert_not_nil @network.errors[attibute]
    end
  end

  test 'invalid network with duplicate name on venue' do
    network = build(:network, { venue: @network.venue, name: @network.name })
    assert_not network.valid?
    assert_not_nil network.errors[:name]
  end

  test 'destroy networks when venue destroyed' do
    venue = @network.venue
    assert venue.destroy
    assert_empty Network.where(venue_id: venue.id)
  end
end
