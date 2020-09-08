json.venue do
  if @venue.photos.attached?
    json.photos @venue.photos do |photo|
      if photo.blob.persisted?
        json.url url_for(photo.variant(resize_to_limit: [120, 120]))
        json.id photo.id
      end
    end
  end

  json.errors @venue.errors.messages.transform_keys { |k| k.to_s.camelize(:lower) }
end

if flash.present?
  json.flashes flash do |key, value|
    json.key key
    json.value value
  end

  flash.clear
end
