# frozen_string_literal: true

class CreateDigitalCodes < ActiveRecord::Migration[6.0]
  def change
    create_table :digital_codes do |t|
      t.string :name
      t.string :password
      t.references :venue, index: true

      t.timestamps

      t.index %i(name venue_id), unique: true
    end
  end
end
