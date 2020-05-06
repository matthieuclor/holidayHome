
json.venue do
  json.(
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
    :creator_id,
    :family_id
  )

  json.errors @venue.errors.messages.transform_keys { |k| k.to_s.camelize(:lower) }

  json.bedrooms @venue.bedrooms do |bedroom|
    json.(bedroom, :id, :name, :_destroy)
    json.errors bedroom.errors.messages

    json.beddings bedroom.beddings do |bedding|
      json.(bedding, :id, :bed_count, :bed_type, :_destroy)
      json.t_bed_type Bedding.human_attribute_name("bed_type.#{bedding.bed_type}")
    end
  end

  json.bathrooms @venue.bathrooms do |bathroom|
    json.(bathroom, :id, :name, :_destroy)
    json.errors bathroom.errors.messages
  end

  json.keys @venue.keys do |key|
    json.(key, :id, :name, :_destroy)
    json.errors key.errors.messages
  end

  json.networks @venue.networks do |network|
    json.(network, :id, :name, :password, :_destroy)
    json.errors network.errors.messages
  end

  json.digital_codes @venue.digital_codes do |digital_code|
    json.(digital_code, :id, :name, :password, :_destroy)
    json.errors digital_code.errors.messages
  end

  json.home_services @venue.home_services do |home_service|
    json.(
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
