# frozen_string_literal: true

class Key < ApplicationRecord
  belongs_to :venue, counter_cache: true
  belongs_to :owner

  validates :name, :owner, :venue, presence: true
  validates :name, uniqueness: { scope: :venue_id }

  def to_builder
    Jbuilder.new do |key|
      key.(self, :id, :name, :owner_id, :_destroy)
    end
  end
end
