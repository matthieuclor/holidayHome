# frozen_string_literal: true

class AddIndexToFamilyLinks < ActiveRecord::Migration[6.0]
  def change
    add_index :family_links, %i(family_id user_id), unique: true
  end
end
