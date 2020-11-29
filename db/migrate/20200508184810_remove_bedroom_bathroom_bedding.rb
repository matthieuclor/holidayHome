# frozen_string_literal: true

class RemoveBedroomBathroomBedding < ActiveRecord::Migration[6.0]
  def change
    drop_table :bedrooms
    drop_table :bathrooms
    drop_table :beddings
  end
end
