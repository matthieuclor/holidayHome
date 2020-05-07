# frozen_string_literal: true

module UserAccount
  class VenuesController < UserAccount::ApplicationController
    include CurrentFamily

    before_action :set_current_family, only: [:index, :new, :create, :edit, :update]
    before_action :set_venue, only: [:show, :edit, :update, :destroy]

    def index
      respond_to do |format|
        format.html
        format.json do
          @pagy, @venues = pagy(
            @current_family
              .venues
              .with_attached_photos
              .includes(bedrooms: [:beddings]),
              items: 5
          )

          @venues = VenueDecorator.wrap(@venues)
        end
      end
    end

    def show
      @venue = VenueDecorator.new(@venue)
    end

    def new
      @owners = @current_family.users.select(:id, :first_name, :last_name)
      @venue = @current_family.venues.build(creator: current_user)
      %i(bathrooms keys networks digital_codes home_services).each do |nested|
        @venue.send(nested).build
      end

      @venue.bedrooms.build(
        beddings: Bedding.bed_types.keys.map { |k, v| Bedding.new(bed_type: k) }
      )
    end

    def create
      @venue = Venue.new(venue_params)

      if @venue.save
        render :create, status: :created
      else
        pp @venue.errors
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @venue.update(venue_params)
        render :update, status: :ok
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      if @venue.destroy
        render :edit, status: :unprocessable_entity
      else
        render nothing: true, status: :ok
      end
    end

    private

    def set_venue
      @venue = Venue
        .with_attached_photos
        .includes(
          :bathrooms,
          :home_services,
          :networks,
          :digital_codes,
          bedrooms: [:beddings],
          keys: [:owner]
        ).find(params[:id])
    end

    def venue_params
      params.require(:venue).permit(
        :id,
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
        :editable_for_others,
        :creator_id,
        :family_id,
        photos: [],
        bathrooms_attributes: [
          :id,
          :name,
          :_destroy
        ],
        keys_attributes: [
          :id,
          :name,
          :owner_id,
          :_destroy
        ],
        networks_attributes: [
          :id,
          :name,
          :connection_type,
          :network_name,
          :password,
          :_destroy
        ],
        digital_codes_attributes: [
          :id,
          :name,
          :password,
          :_destroy
        ],
        home_services_attributes: [
          :id,
          :name,
          :person_in_charge,
          :address,
          :phone,
          :email,
          :_destroy
        ],
        bedrooms_attributes: [
          :id,
          :name,
          :_destroy,
          beddings_attributes: [
            :id,
            :bed_type,
            :bed_count,
            :bedroom_id,
            :_destroy
          ]
        ]
      )
    end
  end
end
