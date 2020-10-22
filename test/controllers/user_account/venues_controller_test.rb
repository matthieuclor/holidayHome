# frozen_string_literal: true

require 'test_helper'

module UserAccount
  class VenuesControllerTest < ActionDispatch::IntegrationTest
    setup do
      @user = users(:matthieu)
      sign_in @user, scope: :user
    end

    test "redirected if not logged in" do
      sign_out :user
      get user_account_venues_url
      assert_redirected_to new_user_session_url
    end

    test "should get index" do
      get user_account_venues_url
      current_family = @controller.view_assigns["current_family"]
      assert_instance_of Family, current_family
      assert_response :success
    end

    test "should get index as json" do
      get user_account_venues_url, as: :json
      current_family = @controller.view_assigns["current_family"]
      pagy = @controller.view_assigns["pagy"]
      venues = @controller.view_assigns["venues"]

      assert_instance_of Family, current_family
      assert_instance_of VenueDecorator, venues.first
      assert_instance_of Pagy, pagy
      assert_response :success
    end

    test "should get show as json" do
      get user_account_venue_url(venues(:la_tania)), as: :json
      venue = @controller.view_assigns["venue"]

      assert_instance_of VenueDecorator, venue
      assert_response :success
    end

    test "should get new as json" do
      get new_user_account_venue_url, as: :json
      current_family = @controller.view_assigns["current_family"]
      owners = @controller.view_assigns["owners"]
      venue = @controller.view_assigns["venue"]

      assert_instance_of Family, current_family
      assert_instance_of User, owners.first
      assert_instance_of Venue, venue
      assert_instance_of Key, venue.keys.first
      assert_instance_of Network, venue.networks.first
      assert_instance_of DigitalCode, venue.digital_codes.first
      assert_instance_of HomeService, venue.home_services.first

      assert venue.new_record?
      assert venue.keys.first.new_record?
      assert venue.networks.first.new_record?
      assert venue.digital_codes.first.new_record?
      assert venue.home_services.first.new_record?

      assert_response :success
    end

    test "should create first venue with basic plan as json" do
      sign_out :user
      sign_in users(:alex), scope: :user

      post user_account_venues_url, params: { venue: {
        name: 'PLG',
        address: '12 rue du test',
        with_network: true,
        with_digital_code: true,
        with_home_service: true,
        comment: 'voici un commentaire.',
        editable_for_others: true,
        bedrooms_count: 4,
        bathrooms_count: 2,
        single_beds_count: 4,
        double_beds_count: 2,
        baby_beds_count: 1,
        creator_id: 10,
        family_id: 3,
        keys_attributes: [name: 'Clé', owner_id: 1],
        networks_attributes: [
          name: 'Livebox',
          password: 'UIYGKF6784GHJB'
        ],
        digital_codes_attributes: [name: 'Porte', password: 'E7689B'],
        home_services_attributes: [
          name: 'Jardinier',
          person_in_charge: 'Matthieu',
          address: '12 Rue du test',
          phone: '06 87 65 34 56',
          email: 'matthieu@mail.com'
        ]
      } }, as: :json

      assert_response :success
    end

    test "should not create second venue with basic plan as json" do
      post user_account_venues_url, params: { venue: {
        name: 'PLG',
        address: '12 rue du test',
        with_network: true,
        with_digital_code: true,
        with_home_service: true,
        comment: 'voici un commentaire.',
        editable_for_others: true,
        bedrooms_count: 4,
        bathrooms_count: 2,
        single_beds_count: 4,
        double_beds_count: 2,
        baby_beds_count: 1,
        creator_id: 1,
        family_id: 1,
        keys_attributes: [name: 'Clé', owner_id: 1],
        networks_attributes: [
          name: 'Livebox',
          password: 'UIYGKF6784GHJB'
        ],
        digital_codes_attributes: [name: 'Porte', password: 'E7689B'],
        home_services_attributes: [
          name: 'Jardinier',
          person_in_charge: 'Matthieu',
          address: '12 Rue du test',
          phone: '06 87 65 34 56',
          email: 'matthieu@mail.com'
        ]
      } }, as: :json

      assert_response :unprocessable_entity
    end

    test "should create second venue with premium plan as json" do
      @user.premium!

      post user_account_venues_url, params: { venue: {
        name: 'PLG',
        address: '12 rue du test',
        with_network: true,
        with_digital_code: true,
        with_home_service: true,
        comment: 'voici un commentaire.',
        editable_for_others: true,
        bedrooms_count: 4,
        bathrooms_count: 2,
        single_beds_count: 4,
        double_beds_count: 2,
        baby_beds_count: 1,
        creator_id: 1,
        family_id: 1,
        keys_attributes: [name: 'Clé', owner_id: 1],
        networks_attributes: [
          name: 'Livebox',
          password: 'UIYGKF6784GHJB'
        ],
        digital_codes_attributes: [name: 'Porte', password: 'E7689B'],
        home_services_attributes: [
          name: 'Jardinier',
          person_in_charge: 'Matthieu',
          address: '12 Rue du test',
          phone: '06 87 65 34 56',
          email: 'matthieu@mail.com'
        ]
      } }, as: :json

      assert_response :success
    end

    test "should get edit as json" do
      get edit_user_account_venue_url(venues(:la_tania)), as: :json
      current_family = @controller.view_assigns["current_family"]
      venue = @controller.view_assigns["venue"]

      assert_instance_of Family, current_family
      assert_instance_of Venue, venue
      assert_response :success
    end

    test "should update venue as json" do
      patch user_account_venue_url(
        venues(:la_tania)
      ), params: { venue: { name: 'La Tania updated' } }, as: :json

      assert_response :success
    end

    test "should destroy venue as json" do
      delete user_account_venue_url(venues(:la_tania)), as: :json
      assert_response :success
    end
  end
end
