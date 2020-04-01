class CreateFamilyLinks < ActiveRecord::Migration[6.0]
  def change
    create_table :family_links do |t|
      t.references :user, index: true
      t.references :family, index: true
    end
  end
end
