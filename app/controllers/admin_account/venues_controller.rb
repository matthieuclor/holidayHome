# frozen_string_literal: true

module AdminAccount
  class VenuesController < AdminAccount::ApplicationController
    respond_to :js, :html
    before_action :venue, only: %i(show edit update)

    def show
      @venue = VenueDecorator.new(
        Venue.with_attached_photos
             .with_attached_map
             .includes(
               :networks,
               :digital_codes,
               :home_services,
               :vehicles,
               keys: [:owner]
             ).find(params[:id])
      )
    end

    def edit
    end

    def update
      if @venue.update(venue_params)
        flash[:success] = t('.success')
        render js: 'location.reload()'
      else
        flash[:error] = t('.error')
        render :edit
      end
    end

    private

    def venue
      @venue ||= Venue.find(params[:id])
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
        :bedrooms_count,
        :bathrooms_count,
        :single_beds_count,
        :double_beds_count,
        :baby_beds_count,
        :single_sofa_beds_count,
        :double_sofa_beds_count,
        :with_network,
        :with_digital_code,
        :with_home_service,
        :with_washing_machine,
        :with_tumble_dryer,
        :with_dishwasher,
        :comment,
        :editable_for_others
      )
    end
  end
end
