# frozen_string_literal: true

class SynchronizeSchoolHolidays
  include Interactor
  include WithTransaction

  def call
    @base_query = "#startswith(zones, \"Zone\") AND (#exact(population, \"Élèves\") OR #null(population))"
    @rows, @start, @i, @query, @running = [50, 0, 0, query, true]

    call_education_api while @running

    SchoolHoliday.where(from: nil)
                 .or(SchoolHoliday.where(to: nil))
                 .each do |school_holiday|
      next if school_holiday.created_at.today?
      @query = @base_query + " AND #exact(description, \"#{school_holiday.description}\") AND #exact(zones, \"#{school_holiday.zone}\") AND #exact(annee_scolaire, \"#{school_holiday.school_year}\")"
      @start, @i, @running = [0, 0, true]
      call_education_api while @running
    end
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
        fields = record["fields"]

        school_holiday = SchoolHoliday.find_by(
          description: fields["description"],
          zone: fields["zones"],
          school_year: fields["annee_scolaire"]
        )

        if school_holiday
          unless school_holiday.from && school_holiday.to
            school_holiday.update(
              from: fields["start_date"] ? Date.parse(fields["start_date"]) : nil,
              to: fields["end_date"] ? Date.parse(fields["end_date"]) : nil
            )
          end

          unless school_holiday.locations.include?(fields["location"])
            school_holiday.locations << fields["location"]
            school_holiday.save
          end
        else
          SchoolHoliday.create(
            description: fields["description"],
            zone: fields["zones"],
            school_year: fields["annee_scolaire"],
            from: fields["start_date"] ? Date.parse(fields["start_date"]) : nil,
            to: fields["end_date"] ? Date.parse(fields["end_date"]) : nil,
            locations: [fields["location"]]
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
    school_years = SchoolHoliday.pluck(:school_year).uniq
      .map { |school_year| " NOT annee_scolaire: \"#{school_year}\"" }

    school_years.present? ? @base_query + school_years.join : @base_query
  end
end
