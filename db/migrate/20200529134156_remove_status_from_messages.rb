# frozen_string_literal: true

class RemoveStatusFromMessages < ActiveRecord::Migration[6.0]
  def change
    remove_column :messages, :status
  end
end
