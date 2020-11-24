class AddIndexToHomeServices < ActiveRecord::Migration[6.0]
  def change
    add_index :home_services, [:name, :venue_id], unique: true
  end
end
