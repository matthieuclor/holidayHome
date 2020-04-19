# frozen_string_literal: true

module UserAccount
  class VenuesController < UserAccount::ApplicationController
    include CurrentFamily

    before_action :set_current_family, only: [:index, :new, :create, :edit, :update]
    before_action :set_venue, only: [:edit, :update, :destroy]

    def index
      @venues = @current_family
        .venues
        .with_attached_photos
        .includes(:bathrooms, :home_services, :keys, :networks, :digital_codes, bedrooms: [:beddings])
    end

    def new
      @venue = @current_family.venues.build(creator: current_user)
      %i(bathrooms keys networks digital_codes home_services).each do |nested|
        @venue.send(nested).build
      end

      @venue.bedrooms.build(
        beddings: Bedding.bed_types.keys.map { |k, v| Bedding.new(bed_type: k) }
      )

      build_json_objects
    end

    def create
      @venue = Venue.new(venue_params)

      if @venue.save
        flash[:success] = "Le lieu a bien été créé"
        render js: "location.reload()"
      else
        build_json_objects
        flash[:error] = "Un problem est survenu lors de la creation du lieu"
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      build_json_objects
    end

    def update
      if @venue.update(venue_params)
        flash[:success] = "Le lieu a bien été mis à jour"
        render js: "location.reload()"
      else
        build_json_objects
        flash[:error] = "Un problem est survenu lors de la mise à jour du lieu"
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      if @venue.destroy
        flash[:success] = "La lieu a bien été supprimée"
      else
        flash[:error] = "Un problem est survenu lors de la suppression du lieu"
      end

      redirect_to user_account_venues_path
    end

    private

    def set_venue
      @venue = Venue.find(params[:id])
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

    def build_json_objects
      @json_venue = @venue.to_builder.target!
      @json_new_bathroom = Bathroom.new.to_builder.target!
      @json_new_key = Key.new.to_builder.target!
      @json_new_network = Network.new.to_builder.target!
      @json_new_digital_code = DigitalCode.new.to_builder.target!
      @json_new_home_service = HomeService.new.to_builder.target!
      @json_new_bedroom = Bedroom.new(
        beddings: Bedding.bed_types.keys.map { |k, v| Bedding.new(bed_type: k) }
      ).to_builder.target!
    end
  end
end
