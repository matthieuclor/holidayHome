# frozen_string_literal: true

require 'test_helper'

module UserAccount
  class SendedInvitationsControllerTest < ActionDispatch::IntegrationTest
    setup do
      @user = users(:matthieu)
      sign_in @user, scope: :user
    end

    test 'redirected if not logged in' do
      sign_out :user
      get user_account_sended_invitations_url
      assert_redirected_to new_user_session_url
    end

    test 'should get index and update notification' do
      notification = notifications(:notification_accepted_invitation_from_matthieu)
      notification.unread!

      get user_account_sended_invitations_url

      invitations = @controller.view_assigns['invitations']
      pagy = @controller.view_assigns['pagy']

      assert_instance_of InvitationDecorator, invitations.first
      assert_instance_of Pagy, pagy
      assert notification.reload.readed?
      assert_response :success
    end

    test 'should get new' do
      get new_user_account_sended_invitation_url, xhr: true
      invitation = @controller.view_assigns['invitation']

      assert_instance_of Invitation, invitation
      assert invitation.new_record?
      assert_response :success
    end

    test 'should create invitation with existing user' do
      assert_enqueued_jobs 1, only: NewNotificationJob do
        post user_account_sended_invitations_url, params: { invitation: { email: users(:sophie).email } }, xhr: true
      end

      invitation = @controller.view_assigns['invitation']
      current_user = @controller.view_assigns['current_user']
      notification = Notification.unread.last

      assert_equal invitation.family_id, current_user.current_family_id
      assert_equal notification.notification_type, 'new_invitation'
      assert_equal notification.user_id, invitation.receiver_id
      assert_equal notification.family_id, invitation.family_id
      assert_response :success
    end

    test 'should create invitation with unexisting user' do
      assert_enqueued_jobs 0, only: NewNotificationJob do
        post user_account_sended_invitations_url,
             params: { invitation: { email: 'unexisting_user@mail.com' } },
             xhr: true
      end

      invitation = @controller.view_assigns['invitation']
      current_user = @controller.view_assigns['current_user']

      assert_equal invitation.family_id, current_user.current_family_id
      assert_response :success
    end

    test 'should destroy invitation' do
      @invitation = invitations(:matthieu_invite_olivia)
      delete user_account_sended_invitation_url(@invitation)
      assert_not @user.sended_invitations.include?(@invitation)
      assert_redirected_to user_account_sended_invitations_url
    end
  end
end
