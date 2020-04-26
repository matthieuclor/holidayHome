# frozen_string_literal: true

class Network < ApplicationRecord
  belongs_to :venue

  validates :name, :venue, presence: true
  validates :name, uniqueness: { scope: :venue_id }

  def to_builder
    Jbuilder.new do |network|
      network.(self,
               :id,
               :name,
               :password,
               :_destroy)

      network.errors self.errors.messages.transform_keys { |k| k.to_s.camelize(:lower) }
    end
  end
end
