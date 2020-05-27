# frozen_string_literal: true

module UserAccount
  class BookingsController < UserAccount::ApplicationController
    include CurrentVenue, CurrentFamily
    before_action :set_current_family, only: [:index]

    def index
      @query = @current_family.bookings.ransack(bookings_ransack_params)
      @pagy, @bookings = pagy(@query.result.joins(:user, :venue))
      @bookings = BookingDecorator.wrap(@bookings)
    end

    def show
      @booking = BookingDecorator.new(
        Booking.includes(
          :user,
          booking_approvals: [:user],
          messages: [user: [:avatar_attachment]],
          venue: [:photos_attachments]
        ).find(params[:id])
      )

      @message = Message.new(booking_id: @booking.id, user: current_user)
    end

    def create
      new_booking = Booking.new(
        booking_params.merge(
          user_id: current_user.id,
          venue_id: current_user.current_venue_id[current_user.current_family_id.to_s]
        )
      )

      new_booking.messages.first.user = current_user

      if new_booking.save
        flash[:success] = "La réservation a bien été créé"
        render :create, status: :created
      else
        flash[:error] = "Un problem est survenu lors de la creation de la réservation"
        render :create, status: :unprocessable_entity
      end
    end

    def update
      @booking = Booking.find(params[:id])

      if @booking.update(booking_params)
        flash[:success] = "La réservation a bien été mise à jour"
      else
        flash[:error] = "Un problem est survenu lors de la suppression de la réservation"
      end

      redirect_to user_account_bookings_path
    end

    private

    def booking_params
      params.require(:booking).permit(
        :from,
        :to,
        :status,
        messages_attributes: [:content]
      )
    end

    def bookings_ransack_params
      @bookings_ransack_params ||= params[:q]&.permit(
        :user_id_eq,
        :venue_id_eq,
        :status_eq,
        :from_gteq,
        :to_lteq
      )
    end
  end
end
