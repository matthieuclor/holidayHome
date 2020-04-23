# frozen_string_literal: true

require 'test_helper'

module UserAccount
  class VenuesControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in users(:matthieu), scope: :user
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

    test "should get new" do
      get new_user_account_venue_url, xhr: true
      current_family = @controller.view_assigns["current_family"]
      venue = @controller.view_assigns["venue"]
      json_venue = @controller.view_assigns["json_venue"]
      json_new_bathroom = @controller.view_assigns["json_new_bathroom"]
      json_new_key = @controller.view_assigns["json_new_key"]
      json_new_network = @controller.view_assigns["json_new_network"]
      json_new_digital_code = @controller.view_assigns["json_new_digital_code"]
      json_new_home_service = @controller.view_assigns["json_new_home_service"]
      json_new_bedroom = @controller.view_assigns["json_new_bedroom"]

      [
        "json_venue",
        "json_new_bathroom",
        "json_new_key",
        "json_new_network",
        "json_new_digital_code",
        "json_new_home_service",
        "json_new_bedroom"
      ].each { |attr| assert_instance_of String, binding.local_variable_get(attr) }

      assert_instance_of Family, current_family
      assert_instance_of Venue, venue
      assert_instance_of Bedroom, venue.bedrooms.first
      assert_instance_of Bathroom, venue.bathrooms.first
      assert_instance_of Key, venue.keys.first
      assert_instance_of Network, venue.networks.first
      assert_instance_of DigitalCode, venue.digital_codes.first
      assert_instance_of HomeService, venue.home_services.first

      assert venue.new_record?
      assert venue.bedrooms.first.new_record?
      assert venue.bathrooms.first.new_record?
      assert venue.keys.first.new_record?
      assert venue.networks.first.new_record?
      assert venue.digital_codes.first.new_record?
      assert venue.home_services.first.new_record?

      assert_response :success
    end

    test "should create venue" do
      post user_account_venues_url, params: { venue: {
        name: 'PLG',
        address: '12 rue du test',
        with_network: true,
        with_digital_code: true,
        with_home_service: true,
        comment: 'voici un commentaire.',
        editable_for_others: true,
        creator_id: 1,
        family_id: 1,
        bathrooms_attributes: [name: 'Salle de bain'],
        keys_attributes: [name: 'Clé', owner_id: 1],
        networks_attributes: [
          name: 'Internet',
          connection_type: 'wifi',
          network_name: 'Livebox',
          password: 'UIYGKF6784GHJB'
        ],
        digital_codes_attributes: [name: 'Porte', password: 'E7689B'],
        home_services_attributes: [
          name: 'Jardinier',
          person_in_charge: 'Matthieu',
          address: '12 Rue du test',
          phone: '06 87 65 34 56',
          email: 'matthieu@mail.com'
        ],
        bedrooms_attributes: [
          name: 'Chambre',
          beddings_attributes: [
            { bed_type: 'single', bed_count: 2 },
            { bed_type: 'double', bed_count: 1 },
            { bed_type: 'baby', bed_count: 0 }
          ]
        ]
      } }, xhr: true

      assert_response :success
    end

    test "should get edit" do
      get edit_user_account_venue_url(venues(:la_tania)), xhr: true
      assert_response :success
    end

    test "should update venue" do
      patch user_account_venue_url(
        venues(:la_tania)
      ), params: { venue: { name: 'La Tania updated' } }, xhr: true

      assert_response :success
    end

    test "should destroy venue" do
      delete user_account_venue_url(venues(:la_tania))
      assert_redirected_to user_account_venues_url
    end
  end
end
