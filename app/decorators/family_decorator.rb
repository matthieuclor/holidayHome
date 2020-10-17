# frozen_string_literal: true

class FamilyDecorator < ApplicationDecorator
  def human_days_for_approval
    @human_days_for_approval ||=
      "#{days_for_approval} #{'jour'.pluralize(days_for_approval)}"
  end
end
