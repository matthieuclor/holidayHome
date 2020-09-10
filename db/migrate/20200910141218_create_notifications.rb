class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.string :title
      t.string :description
      t.string :url
      t.integer :status, default: 0
      t.references :user, index: true
      t.references :family, index: true
      t.timestamps
    end
  end
end
