# frozen_string_literal: true

require 'test_helper'

class InvitationTest < ActiveSupport::TestCase # rubocop:disable Metrics/ClassLength
  include ActionMailer::TestHelper

  def setup
    @invitation = invitations(:matthieu_invite_user)
  end

  test 'valid invitation' do
    assert @invitation.valid?
  end

  %i(sender family email).each do |attibute|
    test "invalid invitation without #{attibute}" do
      @invitation.send("#{attibute}=", nil)
      assert_not @invitation.valid?
      assert @invitation.errors[attibute].present?
    end
  end

  test 'valid invitation when they is less than 3 invitations on family' do
    invitation = build(
      :invitation,
      { sender: @invitation.sender, family: @invitation.family, email: 'test@mail.com' }
    )

    assert invitation.valid?
    assert_not invitation.errors[:base].present?
  end

  test 'invalid invitation when they is 3 invitations on family' do
    create(
      :invitation,
      { sender: @invitation.sender, family: @invitation.family }
    )

    invitation = build(
      :invitation,
      { sender: @invitation.sender, family: @invitation.family, email: 'test@mail.com' }
    )

    assert_not invitation.valid?
    assert invitation.errors[:base].present?
  end

  test 'invalid invitation when the family is not the first' do
    @invitation = invitations(:matthieu_reinvite_user)

    invitation = build(
      :invitation,
      { sender: @invitation.sender, family: @invitation.family, email: 'test@mail.com' }
    )

    assert_not invitation.valid?
    assert invitation.errors[:base].present?
  end

  test 'valid invitation when sender is premium' do
    create(
      :invitation,
      { sender: @invitation.sender, family: @invitation.family }
    )

    @invitation.sender.update(plan: :premium, plan_deadline: (Date.current + 1.year))
    @invitation.reload

    invitation = build(
      :invitation,
      { sender: @invitation.sender, family: @invitation.family, email: 'test@mail.com' }
    )

    assert invitation.valid?
    assert_not invitation.errors[:base].present?
  end

  test 'invalid invitation with the wrong email format' do
    @invitation.email = 'test.test.com'
    assert_not @invitation.valid?
    assert @invitation.errors[:email].present?
  end

  test 'invalid invitation with duplicate email on family and pending status' do
    invitation = build(
      :invitation,
      { sender: @invitation.sender, family: @invitation.family, email: @invitation.email }
    )

    assert_not invitation.valid?
    assert invitation.errors[:email].present?
  end

  test 'invalid invitation with existing receiver on family' do
    invitation = build(
      :invitation,
      { sender: @invitation.sender, family: @invitation.family, email: users(:stephanie).email }
    )

    assert_not invitation.valid?
    assert invitation.errors[:email].present?
  end

  test 'set token after create invitation' do
    invitation = create(
      :invitation,
      { sender: @invitation.sender, family: @invitation.family }
    )

    assert_not_nil invitation.token
  end

  test 'set receiver after create invitation with existing receiver email' do
    invitation = create(
      :invitation,
      { sender: @invitation.sender, family: @invitation.family, email: users(:pierre).email }
    )

    assert_not_nil invitation.receiver
  end

  test 'do not have receiver after create invitation with inexisting receiver email' do
    invitation = create(
      :invitation,
      { sender: @invitation.sender, family: @invitation.family }
    )

    assert_nil invitation.receiver
  end

  test 'send send_to_known_user mail and update last_send_at and send_count after create invitation with existing receiver email' do # rubocop:disable Layout/LineLength
    user = users(:pierre)
    invitation = create(
      :invitation,
      { sender: @invitation.sender, family: @invitation.family, email: user.email }
    )

    assert_enqueued_emails(1)

    user_mailer = InvitationMailer.send_to_known_user(invitation, user)
    assert_equal [I18n.t('contact.email')], user_mailer.from
    assert_equal [user.email], user_mailer.to
    assert_equal "Invitation à rejoindre la famille #{invitation.family.name}", user_mailer.subject
    assert_not_nil invitation.last_send_at
    assert_equal 1, invitation.send_count
  end

  test 'send send_to_unknown_user mail and update last_send_at and send_count after create invitation with inexisting receiver email' do # rubocop:disable Layout/LineLength
    invitation = create(
      :invitation,
      { sender: @invitation.sender, family: @invitation.family }
    )

    assert_enqueued_emails(1)

    user_mailer = InvitationMailer.send_to_unknown_user(invitation)
    assert_equal [I18n.t('contact.email')], user_mailer.from
    assert_equal [invitation.email], user_mailer.to
    assert_equal 'Invitation à créer son compte', user_mailer.subject
    assert_not_nil invitation.last_send_at
    assert_equal 1, invitation.send_count
  end
end
