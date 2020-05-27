class RemoveStepFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :step
  end
end
