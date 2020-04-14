# frozen_string_literal: true

class DigitalCode < ApplicationRecord
  belongs_to :venue, counter_cache: true
end
