class AddIndexToInvitations < ActiveRecord::Migration[6.0]
  def change
    add_index :invitations, [:email, :family_id], unique: true
  end
end
