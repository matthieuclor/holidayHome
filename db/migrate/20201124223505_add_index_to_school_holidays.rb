class AddIndexToSchoolHolidays < ActiveRecord::Migration[6.0]
  def change
    add_index :school_holidays, [:description, :zone, :school_year], unique: true
  end
end
