# frozen_string_literal: true

class SynchronizeSchoolHolidaysJob < ApplicationJob
  queue_as :default

  def perform
    SynchronizeSchoolHolidays.call
  end
end
