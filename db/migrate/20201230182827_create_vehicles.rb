# frozen_string_literal: true

class CreateVehicles < ActiveRecord::Migration[6.1]
  def change
    create_table :vehicles do |t|
      t.string :vehicle_type
      t.string :name
      t.integer :size, default: 0
      t.integer :condition, default: 0
      t.text :comment
      t.references :venue, index: true

      t.timestamps

      t.index %i(vehicle_type name venue_id), unique: true
    end
  end
end
