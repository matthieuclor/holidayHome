# frozen_string_literal: true

module AdminAccount
  class VenuesController < AdminAccount::ApplicationController
    respond_to :js, :html
    before_action :set_venue, only: %i(show edit update)

    def show
      @venue = VenueDecorator.new(
        Venue.with_attached_photos
             .with_attached_map
             .includes(
               :networks,
               :digital_codes,
               :home_services,
               keys: [:owner]
             ).find(params[:id])
      )
    end

    def edit
    end

    def update
      if @venue.update(venue_params)
        flash[:success] = 'Le lieu a bien été mise à jour'
        render js: 'location.reload()'
      else
        flash[:error] = 'Un problem est survenu lors de la mise à jour du lieu'
        render :edit
      end
    end

    private

    def set_venue
      @venue = Venue.find(params[:id])
    end

    def venue_params
      params.require(:venue).permit(
        :creator_id,
        :name,
        :address,
        :city,
        :postcode,
        :country,
        :country_code,
        :administrative,
        :county,
        :lat,
        :lng,
        :with_network,
        :with_digital_code,
        :with_home_service,
        :comment,
        :editable_for_others
      )
    end
  end
end
