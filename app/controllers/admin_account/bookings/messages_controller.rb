# frozen_string_literal: true

module AdminAccount
  module Bookings
    class MessagesController < AdminAccount::ApplicationController
      respond_to :js

      def index
        @messages = Message.where(booking_id: params[:booking_id])
      end
    end
  end
end
