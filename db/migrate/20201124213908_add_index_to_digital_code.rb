class AddIndexToDigitalCode < ActiveRecord::Migration[6.0]
  def change
    add_index :digital_codes, [:name, :venue_id], unique: true
  end
end
