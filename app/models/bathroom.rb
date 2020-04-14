# frozen_string_literal: true

class Bathroom < ApplicationRecord
  belongs_to :venue, counter_cache: true
end
