# frozen_string_literal: true

class CreateQuestionAndAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :question_and_answers do |t|
      t.string :question
      t.string :answer
      t.integer :status, default: 0

      t.timestamps

      t.index :question, unique: true
    end
  end
end
