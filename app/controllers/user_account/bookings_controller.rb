# frozen_string_literal: true

module UserAccount
  class BookingsController < UserAccount::ApplicationController
    include CurrentVenue, CurrentFamily

    before_action :set_booking, only: [:show, :edit, :update, :destroy]

    def index
      respond_to do |format|
        format.html {
          set_current_family
          @pagy, @bookings = pagy(
            @current_family.bookings.joins(:user, :venue, :family)
          )
          @bookings = BookingDecorator.wrap(@bookings)
        }
        format.json {
          set_current_venue
          from = Date.parse(params["minDate"])
          to = Date.parse(params["maxDate"])

          @bookings = BookingDecorator.wrap(
            @current_venue
              .bookings
              .where(status: %i(pending accepted))
              .where(from: from..to)
              .or(@current_venue.bookings.where(to: from..to))
          )
        }
      end
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
        flash[:success] = "La réservation a bien été créé"
        render :create, status: :created
      else
        flash[:error] = "Un problem est survenu lors de la creation de la réservation"
        render :create, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
    end

    def destroy
      if @booking.destroy
        flash[:success] = "La réservation a bien été supprimée"
      else
        flash[:error] = "Un problem est survenu lors de la suppression de la réservation"
      end

      redirect_to user_account_bookings_path
    end

    private

    def booking_params
      params.require(:booking).permit(:from, :to)
    end

    def set_booking
      @booking = Booking.find(params[:id])
    end
  end
end
