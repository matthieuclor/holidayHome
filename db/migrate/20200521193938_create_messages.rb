# frozen_string_literal: true

class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.references :user, index: true
      t.references :booking, index: true
      t.text :content
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
