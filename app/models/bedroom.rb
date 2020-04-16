# frozen_string_literal: true

class Bedroom < ApplicationRecord
  belongs_to :venue, counter_cache: true

  enum bed_type: %i(single double)

  validates :name, :bed_type, :venue, presence: true
  validates :bed_type, inclusion: { in: bed_types.keys }
  validates :name, uniqueness: { scope: :venue_id }
end
