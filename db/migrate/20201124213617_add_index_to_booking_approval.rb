class AddIndexToBookingApproval < ActiveRecord::Migration[6.0]
  def change
    add_index :booking_approvals, [:user_id, :booking_id], unique: true
  end
end
