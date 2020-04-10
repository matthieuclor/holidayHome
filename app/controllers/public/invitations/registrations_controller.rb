module Public
  module Invitations
    class RegistrationsController < ApplicationController
      def new
        @invitation = Invitation.find_by(token: params[:token])

        if is_invitation_valid?
          @invitee = User.new(email: @invitation.email)
          @invitee.families << Family.find_by(id: @invitation.family_id)
          @invitee.received_invitations << @invitation
        else
          redirect_to root_path
        end
      end

      def create
        @invitee = User.new(invitee_params)
        @invitee.skip_confirmation!
        @invitee.assign_attributes({
          confirmed_at: Time.now,
          step: :family_created,
          current_family_id: @invitee.families.first.id
        })

        if @invitee.save
          @invitee.received_invitations.last.user_created!
          sign_in(@invitee)
          flash[:success] = "Le compte a bien été créé"
          redirect_to user_account_dashboards_path
        else
          flash[:error] = "Un problem est survenu lors de la creation de votre compte"
          render :new
        end
      end

      private

      def is_invitation_valid?
        unless @invitation.present?
          flash[:error] = "Votre invitation a été éffacée entre temps"
          return false
        end

        if @invitation.receiver_id.present?
          flash[:error] = "Vous avez déja créé votre compte avec cette invitation"
          return false
        end

        return true
      end

      def invitee_params
        params.require(:invitee).permit(
          :first_name,
          :last_name,
          :email,
          :password,
          :password_confirmation,
          :family_ids,
          :received_invitation_ids
        )
      end
    end
  end
end
