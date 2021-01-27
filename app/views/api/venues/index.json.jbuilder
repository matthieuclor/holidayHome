# frozen_string_literal: true

json.venues @venues do |venue|
  json.call(
    venue,
    :id,
    :name,
    :address,
    :beddings_count,
    :lat,
    :lng,
    :bedrooms_count,
    :bathrooms_count,
    :single_beds_count,
    :double_beds_count,
    :baby_beds_count,
    :with_network,
    :with_digital_code,
    :with_home_service,
    :comment,
    :editable_for_others,
    :creator_id,
    :family_id,
    :single_sofa_beds_count,
    :double_sofa_beds_count,
    :with_washing_machine,
    :with_tumble_dryer,
    :with_dishwasher,
    :vehicles_count
  )

  venue.photos.attached? &&
    json.photo_url(venue.photos.first.variant(resize_to_fill: [100, 100]).url)
end
