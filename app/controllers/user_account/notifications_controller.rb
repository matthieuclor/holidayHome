# frozen_string_literal: true

module UserAccount
  class NotificationsController < UserAccount::ApplicationController
    def index
      @query = current_user.notifications
                           .includes(:family)
                           .ransack(notification_ransack_params)

      @pagy, @notifications = pagy(@query.result)
    end

    def show
      notification = current_user.notifications.find_by(id: params[:id])

      if notification && current_user.current_family_id != notification.family_id
        current_user.update(current_family_id: notification.family_id)
      end

      redirect_to notification&.url || :back
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
