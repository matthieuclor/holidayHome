# frozen_string_literal: true

require 'test_helper'

module UserAccount
  class SendedInvitationsControllerTest < ActionDispatch::IntegrationTest
    setup do
      @user = users(:matthieu)
      sign_in @user, scope: :user
    end

    test "redirected if not logged in" do
      sign_out :user
      get user_account_sended_invitations_url
      assert_redirected_to new_user_session_url
    end

    test "should get index" do
      get user_account_sended_invitations_url

      invitations = @controller.view_assigns["invitations"]
      pagy = @controller.view_assigns["pagy"]

      assert_instance_of InvitationDecorator, invitations.first
      assert_instance_of Pagy, pagy
      assert_response :success
    end

    test "should get new" do
      get new_user_account_sended_invitation_url, xhr: true
      invitation = @controller.view_assigns["invitation"]

      assert_instance_of Invitation, invitation
      assert invitation.new_record?
      assert_response :success
    end

    test "should create invitation" do
      post user_account_sended_invitations_url, params: { invitation: { email: 'newinvitee@mail.com' } }, xhr: true
      invitation = @controller.view_assigns["invitation"]
      current_user = @controller.view_assigns["current_user"]

      assert_equal invitation.family_id, current_user.current_family_id
      assert_response :success
    end

    test "should destroy invitation" do
      @invitation = invitations(:matthieu_invite_olivia)
      delete user_account_sended_invitation_url(@invitation)
      assert_not @user.sended_invitations.include?(@invitation)
      assert_redirected_to user_account_sended_invitations_url
    end
  end
end
