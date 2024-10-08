# frozen_string_literal: true

module UserAccount
  class CurrentSchoolHolidayZonesController < UserAccount::ApplicationController
    def update
      current_user.current_school_holiday_zones[zone_params['key']] = zone_params['value']

      if current_user.save
        render status: :ok
      else
        flash[:error] = t('.error')
        render status: :unprocessable_entity
      end
    end

    private

    def zone_params
      params.require(:zone).permit(:key, :value)
    end
  end
end
