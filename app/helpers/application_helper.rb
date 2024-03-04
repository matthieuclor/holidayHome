# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def fa_icon(icon, text = '', options = {})
    tag.i(
      class: [
        options[:prefix] || 'fas',
        "fa-#{icon}",
        options[:class]
      ]
    ) + text
  end

  def fa_check_icon(value, text)
    icon, color, prefix =
      if value.present?
        %w(check-circle text-success fas)
      else
        %w(circle text-secondary far)
      end

    fa_icon(icon, text, class: "mr-2 #{color}", prefix:)
  end

  def plan_badge(record)
    record_class = record.class.name.chomp('Decorator')

    tag.span(
      record_class.constantize.human_attribute_name("plan.#{record.plan}"),
      class: ["badge badge-#{record.premium? ? 'success' : 'secondary'}"],
      data: { toggle: 'tooltip' },
      title: (record.plan_progress_title if record.premium?)
    )
  end

  def network_status_badge(record)
    record_class = record.class.name.chomp('Decorator')

    tag.span(
      record_class.constantize.human_attribute_name("status.#{record.status}"),
      class: ["badge badge-#{record.online? ? 'success' : 'secondary'}"]
    )
  end

  def plan_progress(record)
    tag.div(
      tag.div(
        class: ['progress-bar', ('bg-success' if record.plan_progress_percentage >= 100)],
        role: 'progressbar',
        style: "width: #{record.plan_progress_percentage}%;",
        'aria-valuenow': record.plan_progress_percentage.to_s,
        'aria-valuemin': '0',
        'aria-valuemax': '100'
      ),
      class: 'progress',
      data: { toggle: 'tooltip' },
      title: record.plan_progress_title
    )
  end
end
