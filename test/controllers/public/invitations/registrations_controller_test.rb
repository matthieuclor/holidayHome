# frozen_string_literal: true

require 'test_helper'

module Public
  module Invitations
    class RegistrationsControllerTest < ActionDispatch::IntegrationTest
      def setup
        @invitation = invitations(:matthieu_invite_user)
      end

      test 'should get new' do
        get new_invitation_registrations_url(token: @invitation.token)
        invitee = @controller.view_assigns['invitee']

        assert_instance_of User, invitee
        assert invitee.new_record?
        assert_response :success
      end

      test 'should create invitee' do
        assert_enqueued_jobs 1, only: NewNotificationJob do
          post invitation_registrations_url, params: {
            invitee: {
              first_name: 'Donald',
              last_name: 'Trump',
              email: @invitation.email,
              password: '12345678',
              password_confirmation: '12345678',
              family_ids: 1,
              received_invitation_ids: @invitation.id
            }
          }
        end

        invitee = @controller.view_assigns['invitee']
        notification = Notification.unread.last

        assert_not_nil invitee
        assert invitee.families.last == @invitation.family
        assert invitee.received_invitations.last.accepted?
        assert_equal notification.notification_type, 'accepted_invitation'
        assert_equal notification.user_id, @invitation.sender_id
        assert_equal notification.family_id, @invitation.family_id
        assert_redirected_to user_account_dashboards_url
      end
    end
  end
end
