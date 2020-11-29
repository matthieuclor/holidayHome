# frozen_string_literal: true

class ChangeUsersCurrentVenueIdColumnType < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :current_venue_id
    enable_extension 'hstore'
    add_column :users, :current_venue_id, :hstore, default: {}
    add_index :users, :current_venue_id, using: :gin
  end
end
