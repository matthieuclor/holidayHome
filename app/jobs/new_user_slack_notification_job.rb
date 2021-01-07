# frozen_string_literal: true

class NewUserSlackNotificationJob < ApplicationJob
  queue_as :default

  def perform(id)
    user = UserDecorator.new(User.find(id))
    notifier = Slack::Notifier.new(ENV['SLACK_WEBHOOK_URL'])
    notifier.post(
      text: 'Vous avez un nouvel utilisateur monsieur.',
      attachments: {
        fallback: 'Nouvel utilisateur.',
        color: '#68d391',
        author_name: user.full_name,
        author_link: Rails.application.routes.url_helpers.admin_account_user_url(user.id),
        title: "Plan: #{User.human_attribute_name("plan.#{user.plan}")}",
        text: user.email
      }
    )
  end
end
