# frozen_string_literal: true

json.bookings do
  @bookings.each do |booking|
    (booking.from.to_date..booking.to.to_date).each do |date|
      json.set!(
        date.strftime('%Y-%m-%d'),
        startingDay: date == booking.from.to_date,
        endingDay: date == booking.to.to_date,
        color: booking.accepted? ? '#c6f6d5' : '#feebc8',
        textColor: booking.accepted? ? '#22543d' : '#7b341e'
      )
    end
  end
end
