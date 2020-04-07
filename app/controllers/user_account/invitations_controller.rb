module UserAccount
  class InvitationsController < UserAccount::ApplicationController
    before_action :set_current_family, only: [:index, :new]

    def index
      @pagy, @invitations = pagy(
        current_user.invitations.where(family_id: current_user.current_family_id)
      )
      @invitations = InvitationDecorator.wrap(@invitations)
    end

    def new
      @invitation = current_user.invitations.build
    end

    def create
      @invitation = current_user.invitations.build(invitation_params)
      @invitation.family_id = current_user.current_family_id

      if @invitation.save
        flash[:success] = "L'invitation a bien été envoyé"
        render js: "location.reload()"
      else
        flash[:error] = "Un problem est survenu lors de l'envoie de l'invitation"
        render :new
      end
    end

    private

    def set_current_family
      @current_family = Family.find(current_user.current_family_id)
    end

    def build_invitation
      @invitation = current_user.invitations.build
    end

    def invitation_params
      params.require(:invitation).permit(:email)
    end
  end
end
