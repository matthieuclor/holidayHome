# frozen_string_literal: true

class HomeService < ApplicationRecord
  belongs_to :venue, counter_cache: true
end
