# frozen_string_literal: true

class AddCurrentFamilyIdToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :current_family_id, :bigint
  end
end
