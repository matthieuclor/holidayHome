# frozen_string_literal: true

module UserAccount
  module Authentification
    module Registrations
      class StatusesController < UserAccount::ApplicationController
        def destroy
          current_user.deactivated!
          current_user.bookings.pending.update_all(status: :canceled)
          current_user.bookings.where('bookings.from >= ?', Date.current)
            .where.not(status: :canceled)
            .update_all(status: :canceled)

          redirect_to root_path
        end
      end
    end
  end
end
