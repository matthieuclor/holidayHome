class AddAchievementToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :achievement, :integer, default: 0
  end
end
