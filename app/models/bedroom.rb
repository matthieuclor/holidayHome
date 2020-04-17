# frozen_string_literal: true

class Bedroom < ApplicationRecord
  belongs_to :venue, counter_cache: true

  has_many :beddings

  validates :name, :venue, presence: true
  validates :name, uniqueness: { scope: :venue_id }

  def to_builder
    Jbuilder.new do |bedroom|
      bedroom.(self, :id, :name, :_destroy)
      bedroom.beddings beddings.collect { |bedding| bedding.to_builder.attributes! }
    end
  end
end
