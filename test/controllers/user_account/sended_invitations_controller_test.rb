# frozen_string_literal: true

require 'test_helper'

module UserAccount
  class SendedInvitationsControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in users(:matthieu), scope: :user
    end

    test "redirected if not logged in" do
      sign_out :user
      get user_account_sended_invitations_url
      assert_redirected_to new_user_session_url
    end

    test "should get index" do
      get user_account_sended_invitations_url
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

      assert invitation.family_id == current_user.current_family_id
      assert_response :success
    end

    test "should destroy invitation" do
      delete user_account_sended_invitation_url(invitations(:matthieu_invite_olivia))
      assert_redirected_to user_account_sended_invitations_url
    end
  end
end
