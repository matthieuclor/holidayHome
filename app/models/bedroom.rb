# frozen_string_literal: true

class Bedroom < ApplicationRecord
  belongs_to :venue, counter_cache: true

  has_many :beddings, dependent: :destroy

  validates :name, :venue, presence: true
  validates :name, uniqueness: { scope: :venue_id }

  accepts_nested_attributes_for :beddings, allow_destroy: true
end
