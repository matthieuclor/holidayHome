class AddIndexToKeys < ActiveRecord::Migration[6.0]
  def change
    add_index :keys, [:name, :venue_id], unique: true
  end
end
