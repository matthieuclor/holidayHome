# frozen_string_literal: true

module UserAccount
  class ApplicationController < ActionController::Base
    layout 'user_account/layouts/application'

    before_action :store_previous_url, :authenticate_user!, :set_notifications

    private

    def store_previous_url
      return unless request.get?
      return if request.xhr? || request.path.match(/^\/users/)

      session[:previous_url] = request.fullpath
    end

    def set_notifications
      @unread_notifications = current_user.notifications.joins(:family).unread
    end
  end
end
