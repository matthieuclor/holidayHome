# frozen_string_literal: true

class AddIndexToBookingApproval < ActiveRecord::Migration[6.0]
  def change
    add_index :booking_approvals, %i(user_id booking_id), unique: true
  end
end
