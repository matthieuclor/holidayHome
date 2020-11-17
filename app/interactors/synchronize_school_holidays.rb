# frozen_string_literal: true

class SynchronizeSchoolHolidays
  include Interactor

  def call
    school_years = DataEducationGouv.new(
      rows: 0,
      q: { zones_start: 'Zone', population_eq: ['Élèves', nil] },
      facet: "annee_scolaire"
    ).call

    if school_years.error.present?
      context.fail!(error: "Un problem est survenu lors de la synchronisation : #{school_years.error}")
    end

    school_years.facet_groups.each do |facet_group|
      next unless facet_group["name"] == "annee_scolaire"

      facet_group["facets"].each do |facet|
        school_holidays_count = SchoolHoliday.where(school_year: facet["name"])
                                             .where('school_holidays.from IS NOT NULL')
                                             .where('school_holidays.to IS NOT NULL')
                                             .inject(0) { |sum, x| sum + x.locations.size }

        next if school_holidays_count >= facet["count"]

        DataEducationGouv.new(
          q: { zones_start: 'Zone', population_eq: ['Élèves', nil], annee_scolaire_eq: facet["name"] }
        ).call_in_batchs do |record, error|
          if error.present?
            context.fail!(error: "Un problem est survenu lors de la synchronisation : #{error}")
          end

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
      end
    end
  end
end
