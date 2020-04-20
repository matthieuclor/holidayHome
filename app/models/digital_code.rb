# frozen_string_literal: true

class DigitalCode < ApplicationRecord
  belongs_to :venue, counter_cache: true

  validates :name, :password, :venue, presence: true
  validates :name, uniqueness: { scope: :venue_id }

  def to_builder
    Jbuilder.new do |digital_code|
      digital_code.(self, :id, :name, :password, :_destroy)
      digital_code.errors self.errors.messages.transform_keys { |k| k.to_s.camelize(:lower) }
    end
  end
end
