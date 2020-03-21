module UserAccount
  class ApplicationController < ActionController::Base
    layout "user_account/layouts/application"

    before_action :authenticate_user!
  end
end
