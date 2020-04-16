class CreateBedrooms < ActiveRecord::Migration[6.0]
  def change
    create_table :bedrooms do |t|
      t.string :name
      t.integer :bed_type, default: 0
      t.references :venue, index: true
      t.timestamps
    end
  end
end
