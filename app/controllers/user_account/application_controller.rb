# frozen_string_literal: true

module UserAccount
  class ApplicationController < ActionController::Base
    include Pagy::Backend

    layout 'user_account/layouts/application'

    before_action :store_previous_url, :authenticate_user!, :set_notifications
    before_action -> { raven_context(current_user) }

    private

    def store_previous_url
      return unless request.get?
      return if request.xhr? || request.path.match(/^\/users/)

      session[:previous_url] = request.fullpath
    end

    def set_notifications
      @unread_notifications = current_user.notifications.joins(:family).unread
    end

    def raven_context(user)
      Raven.user_context(id: user.id)
      Raven.extra_context(params: params.to_unsafe_h, url: request.url)
    end
  end
end
