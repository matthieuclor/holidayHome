# frozen_string_literal: true

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
        invitation_query = invitations(:matthieu_invite_olivia)

        patch user_account_sended_invitation_resends_url(invitation_query), xhr: true
        invitation = @controller.view_assigns["invitation"]
        receiver = @controller.view_assigns["invitation"].receiver

        user_mailer = InvitationMailer.send_to_known_user(invitation, receiver)
        assert_emails(1) { user_mailer.deliver_later }

        assert_equal [I18n.t("contact.email")], user_mailer.from
        assert_equal [receiver.email], user_mailer.to
        assert_equal "Invitation à rejoindre la famille #{invitation.family.name}", user_mailer.subject
        assert_equal (invitation_query.send_count + 1), invitation.send_count
        assert_response :success
      end

      test "should not to resend invitation" do
        patch user_account_sended_invitation_resends_url(invitations(:matthieu_reinvite_user)), xhr: true
        assert_response :unprocessable_entity
      end
    end
  end
end
