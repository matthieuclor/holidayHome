class AddCreatorIdToFamilies < ActiveRecord::Migration[6.0]
  def change
    add_reference :families, :creator, index: true
  end
end
