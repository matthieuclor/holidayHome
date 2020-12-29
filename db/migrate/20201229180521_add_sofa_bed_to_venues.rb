class AddSofaBedToVenues < ActiveRecord::Migration[6.1]
  def change
    change_table :venues, bulk: true do |t|
      t.integer :single_sofa_beds_count, default: 0
      t.integer :double_sofa_beds_count, default: 0
      t.boolean :with_washing_machine, default: false
      t.boolean :with_tumble_dryer, default: false
      t.boolean :with_dishwasher, default: false
    end
  end
end
