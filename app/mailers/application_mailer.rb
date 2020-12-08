# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: I18n.t('delivery.email')
  layout 'mailer'
end
