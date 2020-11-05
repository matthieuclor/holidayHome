# frozen_string_literal: true

class AdminDecorator < ApplicationDecorator
  def full_name
    @full_name ||= "#{first_name} #{last_name}"
  end
end
