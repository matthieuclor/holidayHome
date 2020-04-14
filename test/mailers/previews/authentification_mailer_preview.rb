# frozen_string_literal: true

class AuthentificationMailerPreview < ActionMailer::Preview
  def confirmation_instructions
    AuthentificationMailer.confirmation_instructions(User.first, "faketoken", {})
  end

  def email_changed
    AuthentificationMailer.email_changed(User.first, {})
  end

  def password_change
    AuthentificationMailer.password_change(User.first, {})
  end

  def reset_password_instructions
    AuthentificationMailer.reset_password_instructions(User.first, "faketoken", {})
  end

  def unlock_instructions
    AuthentificationMailer.unlock_instructions(User.first, "faketoken", {})
  end
end
