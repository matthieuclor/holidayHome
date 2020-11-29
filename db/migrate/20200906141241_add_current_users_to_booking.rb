# frozen_string_literal: true

class AddCurrentUsersToBooking < ActiveRecord::Migration[6.0]
  def change
    add_column :bookings, :current_users, :string, array: true, default: []
  end
end
