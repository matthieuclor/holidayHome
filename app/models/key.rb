# frozen_string_literal: true

class Key < ApplicationRecord
  belongs_to :venue
  belongs_to :owner, class_name: "User"

  validates :name, :owner, :venue, presence: true
  validates :name, uniqueness: { scope: :venue_id }

  def to_builder
    Jbuilder.new do |key|
      key.(self, :id, :name, :owner, :_destroy)
      key.errors self.errors.messages
    end
  end
end
