# frozen_string_literal: true

class AuthentificationMailer < Devise::Mailer
  helper :application

  include Devise::Controllers::UrlHelpers

  layout 'mailer'

  def headers_for(action, opts)
    super.merge!(template_path: 'authentification_mailer')
  end

  def confirmation_instructions(record, token, opts={})
    @main_title = "Confirmation de votre compte"
    super
  end

  def email_changed(record, opts={})
    @main_title = "Changement de votre email"
    super
  end

  def password_change(record, opts={})
    @main_title = "Changement de votre mot de passe"
    super
  end

  def reset_password_instructions(record, token, opts={})
    @main_title = "Réinitialiser mon mot de passe"
    super
  end

  def unlock_instructions(record, token, opts={})
    @main_title = "Déverouiller mon compte"
    super
  end
end
