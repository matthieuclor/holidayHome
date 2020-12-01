# frozen_string_literal: true

class CreateKeys < ActiveRecord::Migration[6.0]
  def change
    create_table :keys do |t|
      t.string :name
      t.references :owner, index: true
      t.references :venue, index: true

      t.timestamps

      t.index %i(name venue_id), unique: true
    end
  end
end
