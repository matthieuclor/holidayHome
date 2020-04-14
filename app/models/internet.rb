# frozen_string_literal: true

class Internet < ApplicationRecord
  belongs_to :venue, counter_cache: true

  enum type: %i(wifi cable)
end
