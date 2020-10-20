# frozen_string_literal: true

module AdminAccount
  class DashboardsController < AdminAccount::ApplicationController
    def index
      @users_group_by_date = User.unscoped.group('DATE(created_at)').count(:created_at)
      @users_group_by_status = User.unscoped.group(:status).count(:created_at)
      @users_group_by_plans = User.unscoped.group(:plan).count(:created_at)
      @family_group_by_days_for_approval =
        Family.unscoped
              .order(:days_for_approval)
              .group(:days_for_approval)
              .count
              .map { |k, v| ["#{k} jours", v] }
    end
  end
end
