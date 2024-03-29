# frozen_string_literal: true

namespace :bookings do
  desc 'Close finished bookings'
  task close: :environment do
    CloseBookingJob.perform_later
  end
end
