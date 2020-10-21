class AddPlanAndPlanLimitDateToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :plan, :integer, default: 0
    add_column :users, :plan_deadline, :date, default: -> { 'CURRENT_TIMESTAMP' }
  end
end
