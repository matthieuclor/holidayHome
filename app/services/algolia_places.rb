# frozen_string_literal: true

class AlgoliaPlaces
  include Callable
  attr_accessor :hits_per_page, :language, :countries, :app_id, :app_url, :api_key,
                :query, :hits, :error

  def initialize(**args)
    @hits_per_page = args[:hits_per_page] || 5
    @language = args[:language] || 'fr'
    @countries = args[:countries] || 'fr'
    @app_id = args[:app_id] || Rails.application.credentials.dig(:algolia, :places, :app_id)
    @app_url = args[:app_url] || Rails.application.credentials.dig(:algolia, :places, :app_url)
    @api_key = args[:api_key] || Rails.application.credentials.dig(:algolia, :places, :api_key)
    @query = args[:query] || ''
  end

  def call
    response = Faraday.post(app_url) do |req|
      req.headers['X-Algolia-Application-Id'] = app_id
      req.headers['X-Algolia-API-Key'] = api_key
      req.headers['Content-Type'] = 'application/json'
      req.body = {
        hitsPerPage: hits_per_page,
        language: language,
        countries: countries,
        query: query
      }.to_json
    end

    response_body = JSON.parse(response.body)

    if response.success?
      self.hits = response_body['hits']
    else
      self.error = response_body['message']
    end

    self
  end
end
