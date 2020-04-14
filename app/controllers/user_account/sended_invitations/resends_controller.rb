# frozen_string_literal: true

module UserAccount
  module SendedInvitations
    class ResendsController < UserAccount::ApplicationController
      def update
        @invitation = Invitation.find(params[:sended_invitation_id])
        context = SendInvitationEmail.call(invitation: @invitation)

        if context.success?
          flash[:success] = "L'invitation a bien été envoyée."
          render status: :ok
        else
          flash[:error] = context.error
          render status: :unprocessable_entity
        end
      end
    end
  end
end
