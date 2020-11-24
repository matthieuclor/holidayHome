# frozen_string_literal: true

module Public
  module Invitations
    class ResponsesController < ApplicationController
      def new
        @invitation = Invitation.find_by(token: params[:token])

        if invitation_valid?
          if params[:response] == 'yes'
            @invitation.accepted!
            @invitation.receiver.families << @invitation.family
            create_notification(:accepted_invitation)
          else
            @invitation.refused!
            create_notification(:refused_invitation)
          end

          flash[:success] = 'La réponse a bien été prise en compte'
          redirect_to user_account_received_invitations_path
        else
          redirect_to root_path
        end
      end

      private

      def invitation_valid?
        unless @invitation.present?
          flash[:error] = 'Votre invitation a été éffacée entre temps'
          return false
        end

        unless %w(yes no).include?(params[:response])
          flash[:error] = "Votre invitation n'a pas le bon format"
          return false
        end

        if @invitation.accepted? || @invitation.refused?
          flash[:error] = 'Vous avez déja répondu a cette invitation'
          return false
        end

        true
      end

      def create_notification(type)
        receiver = UserDecorator.new(@invitation.receiver)

        Notification.create(
          url: user_account_sended_invitations_path,
          user: @invitation.sender,
          family: @invitation.family,
          notification_type: type,
          description: Notification.human_attribute_name(
            "description.#{type}",
            { receiver_name: receiver.full_name }
          )
        )
      end
    end
  end
end
