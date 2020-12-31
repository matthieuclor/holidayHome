# frozen_string_literal: true

class Vehicle < ApplicationRecord
  belongs_to :venue

  enum size: %i(standard small medium large)
  enum condition: %i(good normal bad broken)

  validates :vehicle_type, :name, :size, :condition, presence: true
  validates :size, inclusion: { in: sizes.keys }
  validates :condition, inclusion: { in: conditions.keys }
  validates :name, uniqueness: { scope: %i(vehicle_type venue) }
end
