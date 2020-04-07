class UserMailer < ApplicationMailer

  def send_to_known_user(invitation, user)
    @user, @invitation = user, invitation
    @main_title = "Invitation à rejoindre la famille #{@invitation.family.name}"
    @sub_title = ""

    mail(to: @user.email, subject: @main_title)
  end

  def send_to_unknown_user(invitation)
    @invitation = invitation
    @main_title = "Invitation à créer son compte"
    @sub_title = ""

    mail(to: @invitation.email, subject: @main_title)
  end
end
