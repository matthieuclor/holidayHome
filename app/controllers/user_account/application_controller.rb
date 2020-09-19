# frozen_string_literal: true

module UserAccount
  class ApplicationController < ActionController::Base
    layout "user_account/layouts/application"

    before_action :authenticate_user!, :set_notifications

    private

    def set_notifications
      @unread_notifications = current_user.notifications.joins(:family).unread
    end
  end
end
