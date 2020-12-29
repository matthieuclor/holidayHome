# frozen_string_literal: true

json.venue do
  json.call(
    @venue,
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
    :bedrooms_count,
    :bathrooms_count,
    :single_beds_count,
    :double_beds_count,
    :baby_beds_count,
    :single_sofa_beds_count,
    :double_sofa_beds_count,
    :with_washing_machine,
    :with_tumble_dryer,
    :with_dishwasher,
    :creator_id,
    :family_id
  )

  json.photo_limit @venue.family.premium? ? 10 : User::PLAN_BASIC_LIMIT[:venues_photos]

  json.current_user_is_the_creator true

  json.errors(@venue.errors.messages.transform_keys { |k| k.to_s.camelize(:lower) })

  json.keys @venue.keys do |key|
    json.call(key, :id, :name, :owner_id, :_destroy)
    json.errors key.errors.messages
  end

  json.networks @venue.networks do |network|
    json.call(network, :id, :name, :password, :_destroy)
    json.errors network.errors.messages
  end

  json.digital_codes @venue.digital_codes do |digital_code|
    json.call(digital_code, :id, :name, :password, :_destroy)
    json.errors digital_code.errors.messages
  end

  json.home_services @venue.home_services do |home_service|
    json.call(
      home_service,
      :id,
      :name,
      :person_in_charge,
      :phone,
      :email,
      :address,
      :_destroy
    )

    json.errors home_service.errors.messages
  end
end

json.owners @owners do |owner|
  json.id owner.id
  json.full_name "#{owner.first_name} #{owner.last_name}"
end

json.plan_error @plan_error if @plan_error

if flash.present?
  json.flashes flash do |key, value|
    json.key key
    json.value value
  end

  flash.clear
end
