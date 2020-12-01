# frozen_string_literal: true

class CreateVenues < ActiveRecord::Migration[6.0]
  def change
    create_table :venues do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :postcode
      t.string :country
      t.string :country_code
      t.string :administrative
      t.string :county
      t.float :lat
      t.float :lng
      t.integer :bedrooms_count, default: 0
      t.integer :bathrooms_count, default: 0
      t.integer :single_beds_count, default: 0
      t.integer :double_beds_count, default: 0
      t.integer :baby_beds_count, default: 0
      t.boolean :with_network, default: false
      t.boolean :with_digital_code, default: false
      t.boolean :with_home_service, default: false
      t.text :comment
      t.boolean :editable_for_others, default: true
      t.references :creator, index: true
      t.references :family, index: true

      t.timestamps

      t.index %i(name family_id), unique: true
    end
  end
end
