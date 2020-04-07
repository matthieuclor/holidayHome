module UserAccount
  module Invitations
    class MailsController < UserAccount::ApplicationController
      def update
        @invitation = Invitation.find(params[:invitation_id])
        context = SendInvitationEmail.call(invitation: @invitation)

        if context.success?
          flash[:success] = "L'invitation a bien été envoyée."
          render js: "location.reload()"
        else
          flash[:error] = context.error
        end
      end
    end
  end
end
