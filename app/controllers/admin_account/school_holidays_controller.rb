# frozen_string_literal: true

module AdminAccount
  class SchoolHolidaysController < AdminAccount::ApplicationController
    respond_to :js, :html

    def index
    end

    def create
      url = "https://data.education.gouv.fr/api/records/1.0/search/"
      q = "#startswith(zones, \"Zone\") AND (#exact(population, \"Élèves\") OR #null(population))"
      school_years = SchoolHoliday
        .select('distinct school_year')
        .pluck(:school_year)
        .map { |school_year| " NOT annee_scolaire: \"#{school_year}\"" }
      q = school_years.present? ? q + school_years.join : q

      response = Faraday.get(
        url,
        {
          dataset: "fr-en-calendrier-scolaire",
          q: q,
          rows: 20,
          start: 0,
          format: "json",
          lang: "FR",
          timezone: "Europe/Berlin"
        },
        { 'Accept' => 'application/json' }
      )

      if response.success?
        JSON.parse(response.body)["records"].each do |record|
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

        flash[:success] = "La synchronisation a bien fonctionnée"
      else
        flash[:error] = "Un problem est survenu lors de la synchronisation : #{response.body}"
      end
    end

    private

    def school_holiday_ransack_params
      @school_holiday_ransack_params ||= params[:q]&.permit(:question_or_answer_cont)
    end
  end
end
