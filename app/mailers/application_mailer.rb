# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: I18n.t('contact.email')
  layout 'mailer'
end
