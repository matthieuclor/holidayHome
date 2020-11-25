# frozen_string_literal: true

require 'test_helper'

module Public
  class QuestionAndAnswersControllerTest < ActionDispatch::IntegrationTest
    test 'should get online Q&As' do
      get question_and_answers_url
      question_and_answers = @controller.view_assigns['question_and_answers']
      assert_instance_of QuestionAndAnswer, question_and_answers.first
      question_and_answers.each { |question_and_answer| assert question_and_answer.online? }
      assert_response :success
    end
  end
end
