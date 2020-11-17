# frozen_string_literal: true

module UserAccount
  module SchoolHolidays
    class RangeController < UserAccount::ApplicationController
      respond_to :json

      def index
        begin
          from = Date.parse(params["minDate"])
          to = Date.parse(params["maxDate"])
        rescue TypeError => e
          head :unprocessable_entity
        end

        current_zones = current_user.current_school_holiday_zones.filter_map do |k, v|
          "Zone #{k}" if v == 'true'
        end

        @school_holidays = SchoolHoliday
          .where(from: from..to, zone: current_zones)
          .where('school_holidays.from IS NOT NULL')
          .where('school_holidays.to IS NOT NULL')
      end
    end
  end
end
