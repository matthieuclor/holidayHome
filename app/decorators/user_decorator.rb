# frozen_string_literal: true

class UserDecorator < ApplicationDecorator
  include ActionView::Helpers::DateHelper

  def full_name
    @full_name ||= "#{first_name} #{last_name}"
  end

  def plan_days_left
    return 0 unless premium?
    days_left = (plan_deadline.to_date - Date.current).to_i
    @plan_days_left ||= days_left < 0 ? 0 : days_left
  end

  def plan_progress_percentage
    @progress_percentage ||= if plan_days_left.zero?
      100.0
    elsif plan_days_left > 365
      0.0
    else
      100.0 - (plan_days_left.to_f/365.0 * 100.0)
    end
  end

  def plan_progress_title
    @plan_progress_title ||= if plan_days_left.zero?
      "Terminé"
    else
      "Il reste #{distance_of_time_in_words(DateTime.now, plan_deadline)}"
    end
  end
end
