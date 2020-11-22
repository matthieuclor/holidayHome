if @algolia_places.error.present?
  json.flashes do
    json.key 'error'
    json.value @algolia_places.error
  end
end
