class CreateInvitations < ActiveRecord::Migration[6.0]
  def change
    create_table :invitations do |t|
      t.references :sender, index: true
      t.references :receiver, index: true
      t.references :family, index: true
      t.string :email, null: false, default: ""
      t.string :token
      t.integer :status, default: 0
      t.datetime :last_send_at
      t.integer :send_count, default: 0
      t.timestamps
    end
  end
end
