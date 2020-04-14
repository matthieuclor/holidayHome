# frozen_string_literal: true

require 'test_helper'

module Public
  module Invitations
    class ResponsesControllerTest < ActionDispatch::IntegrationTest
      setup do
        sign_in users(:olivia), scope: :user
      end

      test "should refuse invitation" do
        get new_responses_url(token: invitations(:matthieu_invite_olivia).token, response: 'no')
        invitation = @controller.view_assigns["invitation"]

        assert invitation.refused?
        assert_redirected_to user_account_received_invitations_url
      end

      test "should accept invitation" do
        get new_responses_url(token: invitations(:matthieu_invite_olivia).token, response: 'yes')
        invitation = @controller.view_assigns["invitation"]

        assert invitation.accepted?
        assert invitation.receiver.families.last == invitations(:matthieu_invite_olivia).family
        assert_redirected_to user_account_received_invitations_url
      end
    end
  end
end
