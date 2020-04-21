# frozen_string_literal: true

class Bedroom < ApplicationRecord
  belongs_to :venue, counter_cache: true

  has_many :beddings, dependent: :destroy

  validates :name, :venue, presence: true
  validates :name, uniqueness: { scope: :venue_id }

  accepts_nested_attributes_for :beddings, allow_destroy: true

  def to_builder
    Jbuilder.new do |bedroom|
      bedroom.(self, :id, :name, :_destroy)
      bedroom.beddings beddings.collect { |bedding| bedding.to_builder.attributes! }
      bedroom.errors self.errors.messages
    end
  end
end
