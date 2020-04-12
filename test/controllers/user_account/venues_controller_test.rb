require 'test_helper'

module UserAccount
  class VenuesControllerTest < ActionDispatch::IntegrationTest
    test "redirected if not logged in" do
      get user_account_venues_url
      assert_redirected_to new_user_session_url
    end
  end
end
