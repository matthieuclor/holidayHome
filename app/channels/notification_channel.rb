# frozen_string_literal: true

class NotificationChannel < ApplicationCable::Channel
  def subscribed
    stream_from "notifiaction_channel_#{current_user.id}"
  end
end
