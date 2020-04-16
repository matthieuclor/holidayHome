# frozen_string_literal: true

class Network < ApplicationRecord
  belongs_to :venue, counter_cache: true

  enum connection_type: %i(wifi cable)

  validates :name, :connection_type, :venue, presence: true
  validates :connection_type, inclusion: { in: connection_types.keys }
  validates :name, uniqueness: { scope: :venue_id }
end
