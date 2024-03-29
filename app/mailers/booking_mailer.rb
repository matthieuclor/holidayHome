# frozen_string_literal: true

class BookingMailer < ApplicationMailer
  def send_approval(booking, user)
    @booking, @user = booking, user
    @sender = UserDecorator.new(booking.user)
    @main_title = "Demande de réservation pour #{@booking.venue.name}"

    mail(to: @user.email, subject: @main_title)
  end

  def send_status(booking)
    @booking, @user = booking, booking.user
    @status = Booking.human_attribute_name("status.#{@booking.status}")
    @main_title = "Réservation #{@status.downcase} pour #{@booking.venue.name}"

    mail(to: @user.email, subject: @main_title)
  end
end
