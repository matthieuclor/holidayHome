# frozen_string_literal: true

class DigitalCode < ApplicationRecord
  belongs_to :venue, counter_cache: true

  validates :name, :password, :venue, presence: true
  validates :name, uniqueness: { scope: :venue_id }
end
