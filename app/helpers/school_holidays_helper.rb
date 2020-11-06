# frozen_string_literal: true

module SchoolHolidaysHelper
  def school_holiday_locations_with_tooltip(school_holiday)
    content_tag(
      :span,
      school_holiday.locations.join(", ").truncate(35),
      data: { toggle: "tooltip" },
      title: school_holiday.locations.join(", ")
    )
  end
end
