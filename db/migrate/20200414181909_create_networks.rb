# frozen_string_literal: true

class CreateNetworks < ActiveRecord::Migration[6.0]
  def change
    create_table :networks do |t|
      t.string :name
      t.integer :connection_type, default: 0
      t.string :network_name
      t.string :password
      t.references :venue, index: true
      t.timestamps
    end
  end
end
