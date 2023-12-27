# frozen_string_literal: true

module AdminAccount
  class BookingsController < AdminAccount::ApplicationController
    respond_to :js, :html
    before_action :booking, only: %i(edit update)

    def show
      @booking = BookingDecorator.new(
        Booking.includes(:user, :venue).find(params[:id])
      )
    end

    def edit
    end

    def update
      if @booking.update(booking_params)
        flash[:success] = t('.success')
        render js: 'location.reload()'
      else
        flash[:error] = t('.error')
        render :edit
      end
    end

    private

    def booking
      @booking ||= Booking.find(params[:id])
    end

    def booking_params
      params.require(:booking).permit(
        :from,
        :to,
        :deadline,
        :status,
        :user_id,
        :venue_id
      )
    end
  end
end
