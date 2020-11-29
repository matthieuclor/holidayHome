# frozen_string_literal: true

class AddCurrentSchoolHolidayZoneToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :current_school_holiday_zones, :hstore, default: { 'A': false, 'B': false, 'C': false }
  end
end
