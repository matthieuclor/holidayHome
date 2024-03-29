# frozen_string_literal: true

module Public
  module Invitations
    class RegistrationsController < ApplicationController
      def new
        @invitation = Invitation.find_by(token: params[:token])

        if invitation_valid?
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
        @invitee.assign_attributes(
          { confirmed_at: Time.current, current_family: @invitee.families.first }
        )

        if @invitee.save
          @invitee.received_invitations.last.accepted!
          sign_in(@invitee)
          create_notification(@invitee.received_invitations.last)
          flash[:success] = 'Le compte a bien été créé'
          redirect_to user_account_dashboards_path
        else
          flash[:error] = 'Un problem est survenu lors de la creation de votre compte'
          render :new
        end
      end

      private

      def invitation_valid?
        unless @invitation.present?
          flash[:error] = 'Votre invitation a été éffacée entre temps'
          return false
        end

        if @invitation.receiver_id.present?
          flash[:error] = 'Vous avez déja créé votre compte avec cette invitation'
          return false
        end

        true
      end

      def create_notification(invitation)
        receiver = UserDecorator.new(invitation.receiver)

        Notification.create(
          url: user_account_sended_invitations_path,
          user: invitation.sender,
          family: invitation.family,
          notification_type: :accepted_invitation,
          description: Notification.human_attribute_name(
            'description.accepted_invitation',
            { receiver_name: receiver.full_name }
          )
        )
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
