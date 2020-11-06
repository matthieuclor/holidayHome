class SchoolHoliday < ApplicationRecord
  default_scope { order(:school_year, :zone) }

  validates :description, :zone, :school_year, :from, :to, presence: true
  validates :description, uniqueness: { scope: [:zone, :school_year, :from, :to] }
end
