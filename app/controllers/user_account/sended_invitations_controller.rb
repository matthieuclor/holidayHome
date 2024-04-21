# frozen_string_literal: true

module UserAccount
  class SendedInvitationsController < UserAccount::ApplicationController
    include CurrentFamily, CheckNotification
    before_action :check_notification, only: :index
    before_action :set_current_family, only: %i(index new create)

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
        create_notification if @invitation.receiver
        flash[:success] = t('.success')
        render js: 'location.reload()'
      else
        @plan_error = @invitation.errors[:base].first
        flash[:error] = @plan_error || t('.error')
        render :new, status: :unprocessable_entity
      end
    end

    def destroy
      @invitation = Invitation.find(params[:id])

      if @invitation.destroy
        flash[:success] = t('.success')
      else
        flash[:error] = t('.error')
      end

      redirect_to user_account_sended_invitations_path
    end

    private

    def invitation_params
      params.require(:invitation).permit(:email)
    end

    def create_notification
      sender = UserDecorator.new(@invitation.sender)

      Notification.create(
        url: user_account_received_invitations_path,
        user: @invitation.receiver,
        family: @invitation.family,
        notification_type: :new_invitation,
        description: Notification.human_attribute_name(
          'description.new_invitation',
          sender_name: sender.full_name
        )
      )
    end
  end
end
