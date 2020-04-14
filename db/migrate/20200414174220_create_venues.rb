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
      t.integer :keys_count, default: 0
      t.boolean :with_internet, default: false
      t.integer :internets_count, default: 0
      t.boolean :with_digital_code, default: false
      t.integer :digital_codes_count, default: 0
      t.integer :home_services_count, default: 0
      t.text :comment
      t.boolean :editable_for_others, default: true
      t.references :creator, index: true
      t.references :family, index: true
      t.timestamps
    end
  end
end
