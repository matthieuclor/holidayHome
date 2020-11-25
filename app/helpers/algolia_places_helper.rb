# frozen_string_literal: true

module AlgoliaPlacesHelper
  def algolia_places_icon_class(hit)
    case hit['_tags'].join
    when ->(tag) { tag.match(/aeroway/) } then 'fas fa-plane'
    when ->(tag) { tag.match(/bus_station/) } then 'fas fa-bus'
    when ->(tag) { tag.match(/townhall/) } then 'fas fa-university'
    when ->(tag) { tag.match(/railway\/station/) } then 'fas fa-train'
    when ->(tag) { tag.match(/address/) } then 'fas fa-map-marker-alt'
    when ->(tag) { tag.match(/city/) } then 'fas fa-city'
    when ->(tag) { tag.match(/country/) } then 'fas fa-globe-americas'
    else
      'fas fa-map-marker-alt'
    end
  end
end
