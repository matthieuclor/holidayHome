# frozen_string_literal: true

require 'test_helper'

module Public
  module Invitations
    class ResponsesControllerTest < ActionDispatch::IntegrationTest
      setup do
        sign_in users(:olivia), scope: :user
      end

      test 'should refuse invitation' do
        assert_enqueued_jobs 1, only: NewNotificationJob do
          get new_responses_url(token: invitations(:alex_invite_olivia).token, response: 'no')
        end

        invitation = @controller.view_assigns['invitation']
        notification = Notification.unread.last

        assert invitation.refused?
        assert_equal notification.notification_type, 'refused_invitation'
        assert_equal notification.user_id, invitation.sender_id
        assert_equal notification.family_id, invitation.family_id
        assert_redirected_to user_account_received_invitations_url
      end

      test 'should accept invitation' do
        new_invitation = invitations(:alex_invite_olivia)

        assert_enqueued_jobs 1, only: NewNotificationJob do
          get new_responses_url(token: new_invitation.token, response: 'yes')
        end

        invitation = @controller.view_assigns['invitation']
        notification = Notification.unread.last

        assert invitation.accepted?
        assert_equal notification.notification_type, 'accepted_invitation'
        assert_equal notification.user_id, invitation.sender_id
        assert_equal notification.family_id, invitation.family_id
        assert_equal invitation.receiver.families.reload.last, new_invitation.family
        assert_redirected_to user_account_received_invitations_url
      end
    end
  end
end
