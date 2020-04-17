class CreateBeddings < ActiveRecord::Migration[6.0]
  def change
    create_table :beddings do |t|
      t.integer :bed_type, default: 0
      t.integer :bed_count, default: 0
      t.references :bedroom, index: true
      t.timestamps
    end
  end
end
