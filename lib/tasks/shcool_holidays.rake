# frozen_string_literal: true

namespace :school_holidays do
  desc 'Synchronize school holidays with gouv api'
  task synchronize: :environment do
    SynchronizeSchoolHolidaysJob.perform_later
  end
end
