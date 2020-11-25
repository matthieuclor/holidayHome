class AddIndexToQuestionAndAnswers < ActiveRecord::Migration[6.0]
  def change
    add_index :question_and_answers, :question, unique: true
  end
end
