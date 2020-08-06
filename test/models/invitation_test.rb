# frozen_string_literal: true

require 'test_helper'

class InvitationTest < ActiveSupport::TestCase
  include ActionMailer::TestHelper

  def setup
    @invitation = invitations(:matthieu_invite_user)
  end

  test "valid invitation" do
    assert @invitation.valid?
  end

  %i(sender family email).each do |attibute|
    test "invalid invitation without #{attibute}" do
      @invitation.send("#{attibute}=", nil)
      assert_not @invitation.valid?
      assert_not_nil @invitation.errors[attibute]
    end
  end

  test "invalid invitation with the wrong email format" do
    @invitation.email = "test.test.com"
    assert_not @invitation.valid?
    assert_not_nil @invitation.errors[:email]
  end

  test "invalid invitation with duplicate email on family and pending status" do
    invitation = build(:invitation, {
      sender: @invitation.sender,
      family: @invitation.family,
      email: @invitation.email
    })

    assert_not invitation.valid?
    assert_not_nil invitation.errors[:email]
  end

  test "invalid invitation with existing receiver on family" do
    invitation = build(:invitation, {
      sender: @invitation.sender,
      family: @invitation.family,
      email: users(:stephanie).email
    })

    assert_not invitation.valid?
    assert_not_nil invitation.errors[:email]
  end

  test "set token after create invitation" do
    invitation = create(:invitation, {
      sender: @invitation.sender,
      family: @invitation.family
    })

    assert_not_nil invitation.token
  end

  test "set receiver after create invitation with existing receiver email" do
    invitation = create(:invitation, {
      sender: @invitation.sender,
      family: @invitation.family,
      email: users(:pierre).email
    })

    assert_not_nil invitation.receiver
  end

  test "do not have receiver after create invitation with inexisting receiver email" do
    invitation = create(:invitation, {
      sender: @invitation.sender,
      family: @invitation.family
    })

    assert_nil invitation.receiver
  end

  test "send send_to_known_user mail and update last_send_at and send_count after create invitation with existing receiver email" do
    user = users(:pierre)
    invitation = create(:invitation, {
      sender: @invitation.sender,
      family: @invitation.family,
      email: user.email
    })

    assert_enqueued_emails(1)

    user_mailer = InvitationMailer.send_to_known_user(invitation, user)
    assert_equal ['hello@hutoki.com'], user_mailer.from
    assert_equal [user.email], user_mailer.to
    assert_equal "Invitation à rejoindre la famille #{invitation.family.name}", user_mailer.subject
    assert_not_nil invitation.last_send_at
    assert_equal 1, invitation.send_count
  end

  test "send send_to_unknown_user mail and update last_send_at and send_count after create invitation with inexisting receiver email" do
    invitation = create(:invitation, {
      sender: @invitation.sender,
      family: @invitation.family,
    })

    assert_enqueued_emails(1)

    user_mailer = InvitationMailer.send_to_unknown_user(invitation)
    assert_equal ['hello@hutoki.com'], user_mailer.from
    assert_equal [invitation.email], user_mailer.to
    assert_equal "Invitation à créer son compte", user_mailer.subject
    assert_not_nil invitation.last_send_at
    assert_equal 1, invitation.send_count
  end
end
