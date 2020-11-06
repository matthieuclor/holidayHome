require 'test_helper'

class SchoolHolidayTest < ActiveSupport::TestCase
  setup do
    @school_holiday = school_holidays(:christmas_holidays)
  end

  test "valid school holiday" do
    assert @school_holiday.valid?
  end

  %i(description zone school_year).each do |attibute|
    test "invalid school holidaywithout #{attibute}" do
      @school_holiday.send("#{attibute}=", nil)
      assert_not @school_holiday.valid?
      assert_not_nil @school_holiday.errors[attibute]
    end
  end

  test "invalid school holiday with duplicate description" do
    school_holiday = build(
      :school_holiday,
      {
        description: @school_holiday.description,
        zone: @school_holiday.zone,
        school_year: @school_holiday.school_year
      }
    )

    assert_not school_holiday.valid?
    assert_not_nil school_holiday.errors[:description]
  end
end
