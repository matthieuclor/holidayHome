# frozen_string_literal: true

json.call(
  @venue,
  :id,
  :name,
  :address,
  :beddings_count,
  :bedrooms_count,
  :bathrooms_count,
  :with_network,
  :single_beds_count,
  :double_beds_count,
  :baby_beds_count,
  :vehicles_count,
  :single_sofa_beds_count,
  :double_sofa_beds_count,
  :with_washing_machine,
  :with_tumble_dryer,
  :with_dishwasher,
  :comment,
  :map_link
)

json.is_editable(
  @venue.editable_for_others || @venue.creator_id == current_user.id
)

if @venue.photos.attached?
  json.photos @venue.photos do |photo|
    json.url photo.variant(resize_to_limit: [550, 300].processed.service_url)
  end
end

@venue.map.attached? &&
  json.map_url(@venue.map.variant(resize_to_limit: [300, 300]).processed.service_url)

json.keys @venue.keys do |key|
  json.call(key, :id, :name)
  json.owner key.owner, :id, :first_name, :last_name
end

json.networks(@venue.networks { |network| json.call(network, :id, :name, :password) })

json.digital_codes @venue.digital_codes do |digital_code|
  json.call(digital_code, :id, :name, :password)
end

json.home_services @venue.home_services do |home_service|
  json.call(home_service, :id, :name, :person_in_charge, :phone, :email, :address)
end
