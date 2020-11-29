# frozen_string_literal: true

class AddIndexToVenues < ActiveRecord::Migration[6.0]
  def change
    add_index :venues, %i(name family_id), unique: true
  end
end
