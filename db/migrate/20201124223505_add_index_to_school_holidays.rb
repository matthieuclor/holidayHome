# frozen_string_literal: true

class AddIndexToSchoolHolidays < ActiveRecord::Migration[6.0]
  def change
    add_index :school_holidays, %i(description zone school_year), unique: true
  end
end
