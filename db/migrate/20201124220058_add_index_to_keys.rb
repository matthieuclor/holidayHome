# frozen_string_literal: true

class AddIndexToKeys < ActiveRecord::Migration[6.0]
  def change
    add_index :keys, %i(name venue_id), unique: true
  end
end
