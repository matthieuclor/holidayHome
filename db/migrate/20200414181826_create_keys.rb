class CreateKeys < ActiveRecord::Migration[6.0]
  def change
    create_table :keys do |t|
      t.string :name
      t.references :owner, index: true
      t.references :venue, index: true
      t.timestamps
    end
  end
end
