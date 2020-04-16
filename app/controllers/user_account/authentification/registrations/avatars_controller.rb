# frozen_string_literal: true

module UserAccount
  module Authentification
    module Registrations
      class AvatarsController < UserAccount::ApplicationController
        def destroy
          current_user.avatar.purge
          redirect_to user_account_settings_path
        end
      end
    end
  end
end
