# frozen_string_literal: true

module UserAccount
  class VenuesController < UserAccount::ApplicationController
    include CurrentFamily

    before_action :set_current_family, only: [:index, :new, :create]

    def index
      @venues = @current_family
        .venues
        .joins(:bedrooms, :bathrooms, :home_services, :keys, :internets, :digital_codes)
    end

    def new
      @venue = @current_family.venues.build(creator: current_user)
    end

    def create
      @venue = Venue.new(venue_params)

      pp @venue

      # if @venue.save
      #   flash[:success] = "Le lieu a bien été créé"
      #   render js: "location.reload()"
      # else
      #   flash[:error] = "Un problem est survenu lors de la creation du lieu"
      #   render :new, status: :unprocessable_entity
      # end
    end

    def edit
    end

    def update
    end

    def destroy
    end

    private

    def venue_params
      params.require(:venues).permit(
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
        :with_internet,
        :with_digital_code,
        :comment,
        :editable_for_others,
        :creator_id,
        :family_id,
        bedroom_ids: [],
        bathroom_ids: [],
        key_ids: [],
        bedroom_ids: [],
        digital_code_ids: [],
        home_service_ids: []
      )
    end
  end
end
