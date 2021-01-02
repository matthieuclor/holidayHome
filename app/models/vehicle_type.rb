# frozen_string_literal: true

class VehicleType < ApplicationRecord
  enum icon_prefix: %i(fas far fal fad)

  validates :name, :icon_prefix, presence: true
  validates :icon_prefix, inclusion: { in: icon_prefixes.keys }
  validates :icon_class, format: {
    with: /\A(fa-)+[a-z]*\z/,
    message: "Doit commencer par 'fa-'"
  }, allow_blank: true

  before_save -> { name.capitalize! }, if: :name_changed?
end
