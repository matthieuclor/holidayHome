class BookingChannel < ApplicationCable::Channel
  def subscribed
    stream_from "booking_channel_#{params[:booking_id]}"
  end

  def unsubscribed
  end
end
