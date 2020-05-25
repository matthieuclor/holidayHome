# frozen_string_literal: true

class BookingDecorator < ApplicationDecorator
  include ActionView::Helpers::DateHelper

  def user_full_name
    "#{user.first_name} #{user.last_name[0]}"
  end

  def label
    "Demande de #{user.first_name}" +
    if accepted?
      " le #{I18n.l(created_at)}"
    else
      " en attente (il reste #{distance_of_time_in_words(DateTime.now, deadline)})"
    end
  end
end
