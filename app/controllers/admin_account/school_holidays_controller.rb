# frozen_string_literal: true

module AdminAccount
  class SchoolHolidaysController < AdminAccount::ApplicationController
    respond_to :js, :html

    def index
      @query = SchoolHoliday.ransack(school_holiday_ransack_params)
      @pagy, @school_holidays = pagy(@query.result)
    end

    def create
      context = SynchronizeSchoolHolidays.call

      if context.success?
        flash[:success] = "La synchronisation a bien fonctionnée"
        render js: "location.reload()"
      else
        flash[:error] = context.error
        render status: :unprocessable_entity
      end
    end

    private

    def school_holiday_ransack_params
      @school_holiday_ransack_params ||= params[:q]&.permit(:school_year_eq, :zone_eq)
    end
  end
end
