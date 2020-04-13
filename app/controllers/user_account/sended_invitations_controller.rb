module UserAccount
  class SendedInvitationsController < UserAccount::ApplicationController
    include CurrentFamily

    before_action :set_current_family, only: [:index, :new, :create]

    def index
      @pagy, @invitations = pagy(
        current_user.sended_invitations.where(family_id: current_user.current_family_id)
      )
      @invitations = InvitationDecorator.wrap(@invitations)
    end

    def new
      @invitation = current_user.sended_invitations.build
    end

    def create
      @invitation = current_user.sended_invitations.build(invitation_params)
      @invitation.family_id = current_user.current_family_id

      if @invitation.save
        flash[:success] = "L'invitation a bien été envoyé"
        render js: "location.reload()"
      else
        flash[:error] = "Un problem est survenu lors de l'envoi de l'invitation"
        render :new, status: :unprocessable_entity
      end
    end

    def destroy
      @invitation = Invitation.find(params[:id])

      if @invitation.destroy
        flash[:success] = "L'invitation a bien été supprimée"
      else
        flash[:error] = "Un problem est survenu lors de la suppression de l'invitation"
      end

      redirect_to user_account_sended_invitations_path
    end

    private

    def invitation_params
      params.require(:invitation).permit(:email)
    end
  end
end
