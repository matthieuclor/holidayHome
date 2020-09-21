# frozen_string_literal: true

module UserAccount
  class ReceivedInvitationsController < UserAccount::ApplicationController
    def index
      @pagy, @invitations = pagy(current_user.received_invitations.joins(:sender))
      @invitations = InvitationDecorator.wrap(@invitations)
    end

    def update
      @invitation = Invitation.find(params[:id])

      if is_invitation_valid?
        if params[:response] == 'no'
          @invitation.refused!
          create_notification(:refused_invitation)
        elsif params[:response] == 'yes'
          @invitation.accepted!
          create_notification(:accepted_invitation)
          current_user.families << @invitation.family
        end

        flash[:success] = "La réponse a bien été prise en compte"
      end

      redirect_to user_account_received_invitations_path
    end

    private

    def is_invitation_valid?
      unless %w(yes no).include?(params[:response])
        flash[:error] = "Votre invitation n'a pas le bon format"
        return false
      end

      return true
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
