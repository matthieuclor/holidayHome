class AddBedroomTypeToVenue < ActiveRecord::Migration[6.0]
  def change
    add_column :venues, :single_beds_count, :integer, default: 0
    add_column :venues, :double_beds_count, :integer, default: 0
    add_column :venues, :baby_beds_count, :integer, default: 0
  end
end
