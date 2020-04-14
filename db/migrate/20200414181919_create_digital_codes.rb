class CreateDigitalCodes < ActiveRecord::Migration[6.0]
  def change
    create_table :digital_codes do |t|
      t.string :name
      t.string :password
      t.references :venue, index: true
      t.timestamps
    end
  end
end
