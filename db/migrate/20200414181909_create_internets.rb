class CreateInternets < ActiveRecord::Migration[6.0]
  def change
    create_table :internets do |t|
      t.string :name
      t.integer :type, default: 0
      t.string :network
      t.string :password
      t.references :venue, index: true
      t.timestamps
    end
  end
end
