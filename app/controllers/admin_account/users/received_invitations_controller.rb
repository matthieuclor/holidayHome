# frozen_string_literal: true

module AdminAccount
  module Users
    class ReceivedInvitationsController < AdminAccount::ApplicationController
      respond_to :js

      def index
        @pagy, @received_invitations = pagy(
          Invitation.where(receiver_id: params[:user_id])
        )

        @received_invitations = InvitationDecorator.wrap(@received_invitations)
      end
    end
  end
end
