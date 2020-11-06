class CreateSchoolHolidays < ActiveRecord::Migration[6.0]
  def change
    create_table :school_holidays do |t|
      t.string :description
      t.string :zone
      t.string :locations, array: true, default: []
      t.string :school_year
      t.date :from
      t.date :to
      t.timestamps
    end
  end
end
