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

          flash[:success] = t('.success')
          redirect_to user_account_received_invitations_path
        else
          redirect_to root_path
        end
      end

      private

      def invitation_valid?
        unless @invitation.present?
          flash[:error] = t('.invitations.error.not_found')
          return false
        end

        unless %w(yes no).include?(params[:response])
          flash[:error] = t('.invitations.error.format')
          return false
        end

        if @invitation.accepted? || @invitation.refused?
          flash[:error] = t('.invitations.error.responded')
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
