class AddIndexToNetworks < ActiveRecord::Migration[6.0]
  def change
    add_index :networks, [:name, :venue_id], unique: true
  end
end
