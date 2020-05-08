require 'test_helper'

class NetworkTest < ActiveSupport::TestCase
  setup do
    @venue = create(:venue_with_dependencies)
  end

  test "should save network with all attributes" do
    network = build(:network, { venue: @venue })
    assert network.save
  end

  %i(name venue).each do |attibute|
    test "should not save network without #{attibute}" do
      network = build(:network, { venue: @venue })
      network.send("#{attibute}=", nil)
      assert_not network.save
    end
  end

  test "should not save network with the same name of other venue network" do
    first_network = create(:network, { venue: @venue })
    second_network = build(:network, {
      venue: first_network.venue,
      name: first_network.name
    })

    assert_not second_network.save
  end
end
