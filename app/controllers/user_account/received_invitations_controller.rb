module UserAccount
  class ReceivedInvitationsController < UserAccount::ApplicationController
    def index
      @pagy, @invitations = pagy(current_user.received_invitations.joins(:sender))
      @invitations = InvitationDecorator.wrap(@invitations)
    end

    def update
      @invitation = Invitation.find(params[:id])

      if params[:response] == 'no'
        @invitation.refused!
      elsif params[:response] == 'yes'
        @invitation.accepted!
        current_user.families << @invitation.family
      end

      flash[:success] = "La réponse a bien été prise en compte"
      redirect_to user_account_received_invitations_path
    end
  end
end
