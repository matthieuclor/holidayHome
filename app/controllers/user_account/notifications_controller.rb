# frozen_string_literal: true

module UserAccount
  class NotificationsController < UserAccount::ApplicationController
    def index
      @query = current_user.notifications.joins(:family).ransack(notifications_ransack_params)
      @pagy, @notifications = pagy(@query.result)
    end

    def show
      notification = current_user.notifications.find_by(id: params[:id])

      if notification
        notification.readed! if notification.unread?

        if current_user.current_family_id != notification.family_id
          current_user.update(current_family: notification.family)
        end
      end

      redirect_to notification&.url || :back
    end

    private

    def notifications_ransack_params
      @notifications_ransack_params ||= params[:q]&.permit(
        :notification_type_eq,
        :family_id_eq,
        :created_at_gteq,
        :created_at_lteq,
        :status_eq
      )
    end
  end
end
