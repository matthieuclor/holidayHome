# frozen_string_literal: true

require 'test_helper'

class DigitalCodeTest < ActiveSupport::TestCase
  setup do
    @digital_code = digital_codes(:digital_code)
  end

  test 'valid digital code' do
    assert @digital_code.valid?
  end

  %i(name password venue).each do |attibute|
    test "should not save digital code without #{attibute}" do
      @digital_code.send("#{attibute}=", nil)
      assert_not @digital_code.valid?
      assert_not_nil @digital_code.errors[attibute]
    end
  end

  test 'invalid digital code with duplica te name on venue' do
    digital_code = build(
      :digital_code,
      {
        venue: @digital_code.venue,
        name: @digital_code.name
      }
    )

    assert_not digital_code.valid?
    assert_not_nil digital_code.errors[:name]
  end

  test 'destroy digital codes when venue destroyed' do
    venue = @digital_code.venue
    assert venue.destroy
    assert_empty DigitalCode.where(venue_id: venue.id)
  end
end
