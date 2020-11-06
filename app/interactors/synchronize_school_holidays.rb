# frozen_string_literal: true

class SynchronizeSchoolHolidays
  include Interactor
  include WithTransaction

  def call
    @rows, @start, @i, @query, @running = [50, 0, 0, query, true]
    call_education_api while @running
  end

  private

  def call_education_api
    response = Faraday.get(
      I18n.t("data_education.url"),
      {
        dataset: I18n.t("data_education.dataset"),
        q: @query,
        rows: @rows,
        start: @start,
        format: "json",
        lang: "FR",
        timezone: "Europe/Berlin"
      },
      { 'Accept' => 'application/json' }
    )

    if response.success?
      records = JSON.parse(response.body)["records"]

      records.each do |record|
        school_holiday = SchoolHoliday.find_by(
          description: record["fields"]["description"],
          zone: record["fields"]["zones"],
          school_year: record["fields"]["annee_scolaire"],
          from: Date.parse(record["fields"]["start_date"]),
          to: Date.parse(record["fields"]["end_date"])
        )

        if school_holiday
          unless school_holiday.locations.include?(record["fields"]["location"])
            school_holiday.locations << record["fields"]["location"]
            school_holiday.save
          end
        else
          SchoolHoliday.create(
            description: record["fields"]["description"],
            zone: record["fields"]["zones"],
            school_year: record["fields"]["annee_scolaire"],
            from: Date.parse(record["fields"]["start_date"]),
            to: Date.parse(record["fields"]["end_date"]),
            locations: [record["fields"]["location"]]
          )
        end
      end

      @i += 1
      @start = @rows * @i
      @running = records.size == @rows
    else
      @running = false
      context.fail!(error: "Un problem est survenu lors de la synchronisation : #{response.body}")
    end
  end

  def query
    q = "#startswith(zones, \"Zone\") AND (#exact(population, \"Élèves\") OR #null(population)) NOT #null(start_date) NOT #null(end_date)"

    school_years = SchoolHoliday.pluck(:school_year).uniq
      .map { |school_year| " NOT annee_scolaire: \"#{school_year}\"" }

    school_years.present? ? q + school_years.join : q
  end
end
