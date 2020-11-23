if @algolia_places.error.present?
  json.flashes do
    json.key 'error'
    json.value @algolia_places.error
  end
end

json.hits @algolia_places.hits do |hit|
  icon_class = case
    when hit["_tags"].join.match(/aeroway/) then "fas fa-plane"
    when hit["_tags"].join.match(/bus_station/) then "fas fa-bus"
    when hit["_tags"].join.match(/townhall/) then "fas fa-university"
    when hit["_tags"].join.match(/railway\/station/) then "fas fa-train"
    when hit["_tags"].join.match(/address/) then "fas fa-map-marker-alt"
    when hit["_tags"].join.match(/city/) then "fas fa-city"
    when hit["_tags"].join.match(/country/) then "fas fa-globe-americas"
    else
      "fas fa-map-marker-alt"
  end

  json.name hit.dig("_highlightResult", "locale_names", 0, "value")

  json.address [
    hit.dig("_highlightResult", "city", 0, "value"),
    hit.dig("_highlightResult", "administrative", 0, "value"),
    hit["country"]
  ].compact.join(", ")

  json.icon_class icon_class
  json.full_address "#{hit.dig("locale_names", 0)}, #{hit.dig("city", 0)}, #{hit.dig("administrative", 0)}, #{hit["country"]}"
  json.city hit.dig("city", 0)
  json.postcode hit.dig("postcode", 0)
  json.country hit["country"]
  json.country_code hit["country_code"]
  json.administrative hit.dig("administrative", 0)
  json.county hit.dig("county", 0)
  json.lat hit.dig("_geoloc", "lat")
  json.lng hit.dig("_geoloc", "lng")
end
