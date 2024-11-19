# frozen_string_literal: true

class VehicleType < ApplicationRecord
  enum icon_prefix: %i(fas far fal fab fad)

  validates :name, :icon_prefix, presence: true
  validates :icon_prefix, inclusion: { in: icon_prefixes.keys }
  validates :name, uniqueness: true
  validates :icon_class, format: { with: /\A(fa-)+[a-z|-]*\z/ }, allow_blank: true

  before_save -> { name.capitalize! }, if: :name_changed?
end
