# frozen_string_literal: true

module AdminAccount
  class ApplicationController < ActionController::Base
    layout 'admin_account/layouts/application'
    before_action :authenticate_admin!
  end
end
