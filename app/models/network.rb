# frozen_string_literal: true

class Network < ApplicationRecord
  belongs_to :venue

  validates :name, :venue, presence: true
  validates :name, uniqueness: { scope: :venue }
end
