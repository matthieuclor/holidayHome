class CreateBookings < ActiveRecord::Migration[6.0]
  def change
    create_table :bookings do |t|
      t.datetime :from
      t.datetime :to
      t.integer :status, default: 0
      t.references :user, index: true
      t.references :venue, index: true
      t.datetime :deadline
      t.timestamps
    end
  end
end
