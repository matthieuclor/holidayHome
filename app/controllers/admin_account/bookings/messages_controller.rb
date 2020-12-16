# frozen_string_literal: true

module AdminAccount
  module Bookings
    class MessagesController < AdminAccount::ApplicationController
      respond_to :js

      def index
        @pagy, @messages = pagy(
          Message.includes(:user).where(booking_id: params[:booking_id]),
          items: 10
        )
      end
    end
  end
end
