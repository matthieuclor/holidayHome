class AddStepToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :step, :integer, default: 0
  end
end
