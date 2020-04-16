# frozen_string_literal: true

class Bathroom < ApplicationRecord
  belongs_to :venue, counter_cache: true

  validates :name, :venue, presence: true
  validates :name, uniqueness: { scope: :venue_id }
end
