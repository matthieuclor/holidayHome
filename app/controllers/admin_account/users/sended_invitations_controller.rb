# frozen_string_literal: true

module AdminAccount
  module Users
    class SendedInvitationsController < AdminAccount::ApplicationController
      respond_to :js

      def index
        @pagy, @sended_invitations = pagy(
          Invitation.where(sender_id: params[:user_id])
        )
      end
    end
  end
end
