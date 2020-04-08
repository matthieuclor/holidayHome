class UserMailerPreview < ActionMailer::Preview
  def send_to_known_user
    UserMailer.send_to_known_user(Invitation.first, User.first)
  end

  def send_to_unknown_user
    UserMailer.send_to_unknown_user(Invitation.first)
  end
end
