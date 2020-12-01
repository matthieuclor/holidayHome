# frozen_string_literal: true

class CreateHomeServices < ActiveRecord::Migration[6.0]
  def change
    create_table :home_services do |t|
      t.string :name
      t.string :person_in_charge
      t.string :address
      t.string :phone
      t.string :email
      t.references :venue, index: true

      t.timestamps

      t.index %i(name venue_id), unique: true
    end
  end
end
