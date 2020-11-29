# frozen_string_literal: true

class AddVenuesCountOnFamily < ActiveRecord::Migration[6.0]
  def change
    add_column :families, :venues_count, :integer, default: 0
  end
end
