class DataEducationGouv
  include DataEducation::QueryMethods
  attr_accessor :url, :dataset, :rows, :start, :format, :lang, :timezone,
                :q, :facet, :query, :records, :facet_groups, :parameters, :error

  def initialize(**args)
    @url = args[:url] || Rails.application.credentials.dig(:data_education, :url)
    @dataset = args[:dataset] || Rails.application.credentials.dig(:data_education, :dataset)
    @rows = args[:rows] || 50
    @start = args[:start] || 0
    @format = args[:format] || "json"
    @lang = args[:lang] || "FR"
    @timezone = args[:timezone] || "Europe/Berlin"
    @q = args[:q] || {}
    @facet = args[:facet]
  end

  def call
    response = Faraday.get(url,
      {
        dataset: dataset,
        q: query || build_query,
        facet: facet,
        rows: rows,
        start: start,
        format: format,
        lang: lang,
        timezone: timezone
      },
      { 'Accept' => 'application/json' }
    )

    response_body = JSON.parse(response.body)

    if response.success?
      self.records = response_body["records"]
      self.parameters = response_body["parameters"]
      self.facet_groups = response_body["facet_groups"]
    else
      self.error = response_body["error"]
    end

    self
  end

  def call_in_batchs
    (1..).each do |i|
      call

      if error.present?
        yield(nil, error)
        break
      else
        records.each { |record| yield(record, error) }
        break unless records.size == rows
      end

      self.start = rows * i
    end
  end

  private

  def build_query
    self.query = ""

    @q.each do |key, value|
      methods = DataEducation::QueryMethods.instance_methods.map(&:to_s).join('|')
      match_data = key.match(/^(?<attribute>\S+)(?<method>#{methods})+$/)
      raise SyntaxError.new("unexpected #{key}") unless match_data

      if value.kind_of?(Array)
        attributes = value.map { |v| send(match_data[:method], match_data[:attribute], v) }
        query << " (#{attributes.join(" OR ")}) AND"
      else
        query << " #{send(match_data[:method], match_data[:attribute], value)} AND"
      end
    end

    self.query = query[1...-4]
  end
end
