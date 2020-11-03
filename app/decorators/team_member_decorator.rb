# frozen_string_literal: true

class TeamMemberDecorator < ApplicationDecorator
  def full_name
    @full_name ||= "#{first_name} #{last_name}"
  end
end
