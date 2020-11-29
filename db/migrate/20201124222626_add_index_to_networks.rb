# frozen_string_literal: true

class AddIndexToNetworks < ActiveRecord::Migration[6.0]
  def change
    add_index :networks, %i(name venue_id), unique: true
  end
end
