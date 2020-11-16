# frozen_string_literal: true

class SchoolHoliday < ApplicationRecord
  default_scope { order(:school_year, :zone) }

  validates :description, :zone, :school_year, presence: true
  validates :description, uniqueness: { scope: [:zone, :school_year] }
end
