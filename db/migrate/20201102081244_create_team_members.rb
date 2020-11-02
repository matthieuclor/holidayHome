class CreateTeamMembers < ActiveRecord::Migration[6.0]
  def change
    create_table :team_members do |t|
      t.string :first_name
      t.string :last_name
      t.string :function
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
