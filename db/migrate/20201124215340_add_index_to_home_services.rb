# frozen_string_literal: true

class AddIndexToHomeServices < ActiveRecord::Migration[6.0]
  def change
    add_index :home_services, %i(name venue_id), unique: true
  end
end
