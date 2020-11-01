require 'test_helper'

class QuestionAndAnswerTest < ActiveSupport::TestCase
  setup do
    @question_and_answer = question_and_answers(:first_question_and_answer)
  end

  test "valid Q&A" do
    assert @question_and_answer.valid?
  end

  test "default Q&A status must be offline" do
    assert @question_and_answer.offline?
  end

  %i(question answer).each do |attibute|
    test "invalid Q&A without #{attibute}" do
      @question_and_answer.send("#{attibute}=", nil)
      assert_not @question_and_answer.valid?
      assert_not_nil @question_and_answer.errors[attibute]
    end
  end

  test "invalid Q&A with duplicate question" do
    question_and_answer = build(
      :question_and_answer,
      { question:  @question_and_answer.question }
    )

    assert_not question_and_answer.valid?
    assert_not_nil question_and_answer.errors[:question]
  end
end
