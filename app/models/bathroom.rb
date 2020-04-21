# frozen_string_literal: true

class Bathroom < ApplicationRecord
  belongs_to :venue, counter_cache: true

  validates :name, :venue, presence: true
  validates :name, uniqueness: { scope: :venue_id }

  def to_builder
    Jbuilder.new do |bathroom|
      bathroom.(self, :id, :name, :_destroy)
      bathroom.errors self.errors.messages
    end
  end
end
