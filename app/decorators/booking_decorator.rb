# frozen_string_literal: true

class BookingDecorator < ApplicationDecorator
  include ActionView::Helpers::DateHelper

  def user_full_name
    @user_full_name ||= "#{user.first_name} #{user.last_name}"
  end

  def label
    @label ||=
      "Demande de #{user.first_name}" +
      (accepted? ? " le #{I18n.l(created_at)}" : " en attente (#{progress_title})")
  end

  def human_date_range
    @human_date_range ||=
      if from == to
        "Le #{I18n.l(from, format: :medium)}"
      elsif from.year == to.year
        if from.month == to.month
          "Du #{from.day} au #{I18n.l(to, format: :medium)}"
        else
          "Du #{I18n.l(from, format: '%d %B')} au #{I18n.l(to, format: :medium)}"
        end
      else
        "Du #{I18n.l(from, format: :medium)} au #{I18n.l(to, format: :medium)}"
      end
  end

  def days_left
    days_left = (deadline.to_date - Date.current).to_i
    @days_left ||= days_left.negative? ? 0 : days_left
  end

  def days_for_approval
    @days_for_approval ||= (deadline.to_date - created_at.to_date).to_i
  end

  def progress_percentage
    @progress_percentage ||=
      if !pending? || days_left.zero?
        100.0
      else
        100.0 - ((days_left / days_for_approval.to_f) * 100.0)
      end
  end

  def progress_title
    @progress_title ||=
      if days_left.zero?
        'Terminé'
      else
        "Il reste #{distance_of_time_in_words(DateTime.now, deadline)}"
      end
  end
end
