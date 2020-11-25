class AddIndexToVenues < ActiveRecord::Migration[6.0]
  def change
    add_index :venues, [:name, :family_id], unique: true
  end
end
