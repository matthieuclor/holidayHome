# frozen_string_literal: true

module AdminAccount
  class ApplicationController < ActionController::Base
    layout 'admin_account/layouts/application'
    before_action :store_admin_previous_url, :authenticate_admin!

    private

    def store_admin_previous_url
      return unless request.get?
      return if request.xhr? || request.path.match(/^\/admins/)

      session[:admin_previous_url] = request.fullpath
    end
  end
end
