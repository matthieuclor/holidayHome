# frozen_string_literal: true

class CreateBathrooms < ActiveRecord::Migration[6.0]
  def change
    create_table :bathrooms do |t|
      t.string :name
      t.references :venue, index: true
      t.timestamps
    end
  end
end
