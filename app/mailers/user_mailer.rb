# frozen_string_literal: true

class UserMailer < ApplicationMailer

  def send_to_known_user(invitation, user)
    @receiver, @invitation, @family = user, invitation, invitation.family
    @sender = UserDecorator.new(@invitation.sender)
    @main_title = "Invitation à rejoindre la famille #{@family.name}"
    @sub_title = ""

    mail(to: @invitation.email, subject: @main_title)
  end

  def send_to_unknown_user(invitation)
    @invitation, @family = invitation, invitation.family
    @sender = UserDecorator.new(@invitation.sender)
    @main_title = "Invitation à créer son compte"
    @sub_title = ""

    mail(to: @invitation.email, subject: @main_title)
  end
end
