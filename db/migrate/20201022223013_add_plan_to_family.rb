# frozen_string_literal: true

class AddPlanToFamily < ActiveRecord::Migration[6.0]
  def change
    add_column :families, :plan, :integer, default: 0
    add_column :families, :plan_deadline, :date
  end
end
