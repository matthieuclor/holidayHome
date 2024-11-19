# frozen_string_literal: true

module UserAccount
  class ReceivedInvitationsController < UserAccount::ApplicationController
    include CheckNotification
    before_action :check_notification, only: :index

    def index
      @pagy, @invitations = pagy(
        current_user.received_invitations.includes(:sender, :family)
      )

      @invitations = InvitationDecorator.wrap(@invitations)
    end

    def update
      @invitation = Invitation.find(params[:id])

      if invitation_valid?
        case params[:response]
        when 'no'
          @invitation.refused!
          create_notification(:refused_invitation)
        when 'yes'
          @invitation.accepted!
          create_notification(:accepted_invitation)
          current_user.families << @invitation.family
        end

        flash[:success] = t('.success')
      end

      redirect_to user_account_received_invitations_path
    end

    private

    def invitation_valid?
      unless %w(yes no).include?(params[:response])
        flash[:error] = t('.invitations.error')
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
