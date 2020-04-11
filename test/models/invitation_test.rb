require 'test_helper'

class InvitationTest < ActiveSupport::TestCase
  include ActionMailer::TestHelper

  test "should save invitation with all attributes" do
    invitation = build(:invitation)

    assert invitation.save
  end

  test "should not save invitation with the wrong email format" do
    invitation = build(:invitation, { email: 'test.test.com' })

    assert_not invitation.save
  end

  %i(sender family email).each do |attibute|
    test "should not save invitation without #{attibute}" do
      invitation = build(:invitation, { attibute => nil })

      assert_not invitation.save
    end
  end

  test "should not save invitation with a wrong status" do
    assert_raises(ArgumentError) do
      create(:invitation, { status: 'test' })
    end
  end

  test "should not save invitation with the same email, family and pending status" do
    first_invitation = create(:invitation)
    invitation = build(
      :invitation,
      { family: first_invitation.family, email: first_invitation.email }
    )

    assert_not invitation.save
  end

  test "should not save invitation with existing receiver on family" do
    user = create(:user_with_families)
    invitation = build(:invitation, { family: user.families.last, email: user.email })

    assert_not invitation.save
  end

  test "should set token after create invitation" do
    invitation = create(:invitation)

    assert_not_nil invitation.token
  end

  test "should set receiver after create invitation with existing receiver email" do
    user = create(:user)
    invitation = create(:invitation, email: user.email)

    assert_not_nil invitation.receiver
  end

  test "should not have receiver after create invitation with inexisting receiver email" do
    invitation = create(:invitation)

    assert_nil invitation.receiver
  end

  test "should send send_to_known_user mail and update last_send_at and send_count after create invitation with existing receiver email" do
    user = create(:user)
    invitation = create(:invitation, email: user.email)
    user_mailer = UserMailer.send_to_known_user(invitation, user)

    assert_emails 1 do
      user_mailer.deliver_later
    end

    assert_equal ['hello@hutoki.com'], user_mailer.from
    assert_equal [user.email], user_mailer.to
    assert_equal "Invitation à rejoindre la famille #{invitation.family.name}", user_mailer.subject
    assert_not_nil invitation.last_send_at
    assert_equal 1, invitation.send_count
  end

  test "should send send_to_unknown_user mail and update last_send_at and send_count after create invitation with inexisting receiver email" do
    invitation = create(:invitation)
    user_mailer = UserMailer.send_to_unknown_user(invitation)

    assert_emails 1 do
      user_mailer.deliver_later
    end

    assert_equal ['hello@hutoki.com'], user_mailer.from
    assert_equal [invitation.email], user_mailer.to
    assert_equal "Invitation à créer son compte", user_mailer.subject
    assert_not_nil invitation.last_send_at
    assert_equal 1, invitation.send_count
  end
end
