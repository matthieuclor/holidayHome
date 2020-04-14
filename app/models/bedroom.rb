# frozen_string_literal: true

class Bedroom < ApplicationRecord
  belongs_to :venue, counter_cache: true

  enum type: %i(single double)
end
