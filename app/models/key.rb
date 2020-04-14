# frozen_string_literal: true

class Key < ApplicationRecord
  belongs_to :venue, counter_cache: true
  belongs_to :owner
end
