# frozen_string_literal: true

module UserAccount
  class VenuesController < UserAccount::ApplicationController
    include CurrentFamily

    before_action :set_current_family, only: %i(index new create edit update)
    before_action :set_venue, only: %i(show edit destroy)
    before_action :set_owners, only: %i(new edit)

    def index
      respond_to do |format|
        format.html { @skip_footer = true }
        format.json do
          @pagy, @venues = pagy(
            @current_family.venues.with_attached_photos,
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
      @venue = @current_family.venues.build(creator: current_user)

      %i(keys networks digital_codes home_services).each do |nested|
        @venue.send(nested).build
      end
    end

    def create
      @venue = Venue.new(venue_params)

      if @venue.save
        flash[:success] = 'Le lieu a bien été créé'
        render :create, status: :created
      else
        @plan_error = @venue.errors[:base].first
        flash[:error] = @plan_error || 'Un problem est survenu lors de la création du lieu'
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      @venue = Venue.find(params[:id])

      if @venue.update(venue_params)
        flash[:success] = 'Le lieu a bien été mise à jour'
        render :update, status: :ok
      else
        flash[:error] = 'Un problem est survenu lors de la mise à jour de du lieu'
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      if @venue.destroy
        flash[:success] = 'Le lieu a bien été supprimé'
        render status: :ok
      else
        flash[:error] = 'Un problem est survenu lors de la suppression du lieu'
        render status: :unprocessable_entity
      end
    end

    private

    def set_venue
      @venue = Venue
        .with_attached_photos
        .includes(:home_services, :networks, :digital_codes, :keys)
        .find(params[:id])
    end

    def set_owners
      @owners = @current_family.users.select(:id, :first_name, :last_name)
    end

    def venue_params
      params.require(:venue).permit(
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
        :bedrooms_count,
        :bathrooms_count,
        :single_beds_count,
        :double_beds_count,
        :baby_beds_count,
        :creator_id,
        :family_id,
        photos: %i(),
        keys_attributes: %i(id name owner_id _destroy),
        networks_attributes: %i(id name connection_type network_name password _destroy),
        digital_codes_attributes: %i(id name password _destroy),
        home_services_attributes: %i(id name person_in_charge address phone email _destroy)
      )
    end
  end
end
