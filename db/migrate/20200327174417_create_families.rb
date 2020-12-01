# frozen_string_literal: true

class CreateFamilies < ActiveRecord::Migration[6.0]
  def change
    create_table :families do |t|
      t.string :name
      t.integer :venues_count, default: 0
      t.integer :days_for_approval
      t.integer :plan, default: 0
      t.date :plan_deadline
      t.references :creator, index: true

      t.timestamps
    end
  end
end
