require 'test_helper'

module UserAccount
  class SendedInvitationsControllerTest < ActionDispatch::IntegrationTest
    test "redirected if not logged in" do
      get user_account_sended_invitations_url
      assert_redirected_to new_user_session_url
    end
  end
end
