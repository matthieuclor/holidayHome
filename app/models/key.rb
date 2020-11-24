# frozen_string_literal: true

class Key < ApplicationRecord
  belongs_to :venue
  belongs_to :owner, class_name: 'User'

  validates :name, :owner, :venue, presence: true
  validates :name, uniqueness: { scope: :venue }
end
