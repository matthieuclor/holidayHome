class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.string :title
      t.string :slug
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
