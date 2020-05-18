class AddDaysForApprovalToFamily < ActiveRecord::Migration[6.0]
  def change
    add_column :families, :days_for_approval, :integer
  end
end
