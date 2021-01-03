# frozen_string_literal: true

class CreateVehicleTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :vehicle_types do |t|
      t.string :name
      t.integer :icon_prefix, default: 0
      t.string :icon_class

      t.timestamps

      t.index :name, unique: true
    end
  end
end
