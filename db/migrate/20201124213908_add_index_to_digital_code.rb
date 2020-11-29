# frozen_string_literal: true

class AddIndexToDigitalCode < ActiveRecord::Migration[6.0]
  def change
    add_index :digital_codes, %i(name venue_id), unique: true
  end
end
