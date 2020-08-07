# frozen_string_literal: true

require 'test_helper'

module UserAccount
  class ReceivedInvitationsControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in users(:olivia), scope: :user
    end

    test "redirected if not logged in" do
      sign_out :user
      get user_account_received_invitations_url
      assert_redirected_to new_user_session_url
    end

    test "should get index" do
      get user_account_received_invitations_url

      invitations = @controller.view_assigns["invitations"]
      pagy = @controller.view_assigns["pagy"]

      assert_instance_of InvitationDecorator, invitations.first
      assert_instance_of Pagy, pagy
      assert_response :success
    end

    test "should accepted invitation" do
      patch user_account_received_invitation_url(invitations(:matthieu_invite_olivia)), params: { response: 'yes' }
      invitation = @controller.view_assigns["invitation"]
      current_user = @controller.view_assigns["current_user"]

      assert invitation.accepted?
      assert current_user.families.include?(invitation.family)
      assert_redirected_to user_account_received_invitations_url
    end

    test "should refused invitation" do
      patch user_account_received_invitation_url(invitations(:matthieu_invite_olivia)), params: { response: 'no' }
      assert @controller.view_assigns["invitation"].refused?
      assert_redirected_to user_account_received_invitations_url
    end
  end
end
