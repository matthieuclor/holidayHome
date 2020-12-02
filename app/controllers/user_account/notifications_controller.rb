# frozen_string_literal: true

module UserAccount
  class NotificationsController < UserAccount::ApplicationController
    def index
      @query = current_user.notifications
                           .includes(:family)
                           .ransack(notification_ransack_params)

      @pagy, @notifications = pagy(@query.result)
    end

    private

    def notification_ransack_params
      @notification_ransack_params ||= params[:q]&.permit(
        :notification_type_eq,
        :family_id_eq,
        :created_at_gteq,
        :created_at_lteq,
        :status_eq
      )
    end
  end
end
