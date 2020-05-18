class CreateBookingApprovals < ActiveRecord::Migration[6.0]
  def change
    create_table :booking_approvals do |t|
      t.references :booking, index: true
      t.references :user, index: true
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
