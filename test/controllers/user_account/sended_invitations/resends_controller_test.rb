require 'test_helper'

module UserAccount
  module SendedInvitations
    class ResendsControllerTest < ActionDispatch::IntegrationTest
      setup do
        sign_in users(:matthieu), scope: :user
      end

      test "redirected if not logged in" do
        sign_out :user
        patch user_account_sended_invitation_resends_url(invitations(:matthieu_invite_olivia)), xhr: true
        assert_response :redirect
      end

      test "should resend invitation" do
        patch user_account_sended_invitation_resends_url(invitations(:matthieu_invite_olivia)), xhr: true
        assert_response :success
      end

      test "should not to resend invitation" do
        patch user_account_sended_invitation_resends_url(invitations(:matthieu_reinvite_user)), xhr: true
        assert_response :unprocessable_entity
      end
    end
  end
end
