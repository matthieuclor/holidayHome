# frozen_string_literal: true

class BookingDecorator < ApplicationDecorator
  include ActionView::Helpers::DateHelper

  def user_full_name
    @user_full_name ||= "#{user.first_name} #{user.last_name}"
  end

  def label
    @label ||= "Demande de #{user.first_name}" +
    if accepted?
      " le #{I18n.l(created_at)}"
    else
      " en attente (il reste #{distance_of_time_in_words(DateTime.now, deadline)})"
    end
  end

  def days_left
    days_left = (deadline.to_date - Date.current).to_i
    @days_left ||= days_left < 0 ? 0 : days_left
  end

  def days_for_approval
    @days_for_approval ||= (deadline.to_date - created_at.to_date).to_i
  end

  def progress_percentage
    @percentage ||= if days_left.zero?
      100.0
    else
      100.0 - (days_left.to_f/days_for_approval.to_f * 100.0)
    end
  end

  def progress_title
    @progress_title ||= if days_left.zero?
      "Terminé"
    else
      "#{days_left}
      #{'jour'.pluralize(days_left)}
      #{'restant'.pluralize(days_left)}"
    end
  end
end
