# frozen_string_literal: true

class AddVehiclesCountToFamily < ActiveRecord::Migration[6.1]
  def change
    change_table :venues, bulk: true do |t|
      t.integer :vehicles_count, default: 0
    end
  end
end
