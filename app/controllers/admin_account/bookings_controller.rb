# frozen_string_literal: true

module AdminAccount
  class BookingsController < AdminAccount::ApplicationController
    respond_to :js, :html
    before_action :set_booking, only: %i(edit update)

    def show
      @booking = BookingDecorator.new(
        Booking.includes(:user, :venue).find(params[:id])
      )
    end

    def edit
    end

    def update
      if @booking.update(booking_params)
        flash[:success] = 'La demande a bien été mise à jour'
        render js: 'location.reload()'
      else
        flash[:error] = 'Un problem est survenu lors de la mise à jour de la demande'
        render :edit
      end
    end

    private

    def set_booking
      @booking = Booking.find(params[:id])
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
