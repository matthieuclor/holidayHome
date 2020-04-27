class AddPhoneToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :current_venue_id, :bigint
    add_column :users, :phone, :string
    add_column :users, :address, :string
  end
end
