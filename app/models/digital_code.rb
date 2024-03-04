# frozen_string_literal: true

class DigitalCode < ApplicationRecord
  belongs_to :venue

  validates :name, :password, presence: true
  validates :name, uniqueness: { scope: :venue }
end
