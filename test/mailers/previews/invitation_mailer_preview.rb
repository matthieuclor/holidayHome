# frozen_string_literal: true

class InvitationMailerPreview < ActionMailer::Preview
  def send_to_known_user
    InvitationMailer.send_to_known_user(Invitation.first, User.first)
  end

  def send_to_unknown_user
    InvitationMailer.send_to_unknown_user(Invitation.first)
  end
end
