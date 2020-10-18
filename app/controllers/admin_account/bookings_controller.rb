# frozen_string_literal: true

module AdminAccount
  class BookingsController < AdminAccount::ApplicationController
    respond_to :js, :html

    def show
      @booking = Booking.find(params[:id])
    end
  end
end
