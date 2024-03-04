# frozen_string_literal: true

class Vehicle < ApplicationRecord
  belongs_to :venue, counter_cache: true

  enum size: %i(standard small medium large)
  enum condition: %i(good normal bad broken)

  validates :vehicle_type, :name, :size, :condition, presence: true
  validates :size, inclusion: { in: sizes.keys }
  validates :condition, inclusion: { in: conditions.keys }
  validates :name, uniqueness: { scope: %i(vehicle_type venue) }

  before_save -> { vehicle_type.capitalize! }, if: :vehicle_type_changed?
  before_save -> { name.capitalize! }, if: :name_changed?
end
