# frozen_string_literal: true

module UserAccount
  class BookingsController < UserAccount::ApplicationController
    include CurrentVenue

    before_action :set_current_venue, only: [:index]

    def index
      from = Date.parse(params["minDate"])
      to = Date.parse(params["maxDate"])

      @bookings = BookingDecorator.wrap(
        @current_venue
          .bookings
          .where(status: %i(pending accepted))
          .where(from: from..to)
          .or(@current_venue.bookings.where(to: from..to))
      )
    end

    def show
    end

    def create
      new_booking = Booking.new(
        booking_params.merge(
          user_id: current_user.id,
          venue_id: current_user.current_venue_id
        )
      )

      if new_booking.save
        flash[:success] = "La demande a bien été créé"
        render :create, status: :created
      else
        flash[:error] = "Un problem est survenu lors de la creation de la demande"
        render :create, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
    end

    def destroy
    end

    private

    def booking_params
      params.require(:booking).permit(:from, :to)
    end
  end
end
