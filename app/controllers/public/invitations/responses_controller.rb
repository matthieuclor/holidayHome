module Public
  module Invitations
    class ResponsesController < ApplicationController
      def new
        @invitation = Invitation.find_by(token: params[:token])

        if is_invitation_valid?
          if params[:response] == 'yes'
            @invitation.accepted!
            @invitation.receiver.families << @invitation.family
          else
            @invitation.refused!
          end

          flash[:success] = "La réponse a bien été prise en compte"
          redirect_to user_account_received_invitations_path
        else
          redirect_to root_path
        end
      end

      private

      def is_invitation_valid?
        unless @invitation.present?
          flash[:error] = "Votre invitation a été éffacée entre temps"
          return false
        end

        unless %w(yes no).include?(params[:response])
          flash[:error] = "Votre invitation n'a pas le bon format"
          return false
        end

        if @invitation.accepted? || @invitation.refused?
          flash[:error] = "Vous avez déja répondu a cette invitation"
          return false
        end

        return true
      end
    end
  end
end
