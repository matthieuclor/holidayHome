# frozen_string_literal: true

module Public
  class QuestionAndAnswersController < ApplicationController
    def index
      @query = QuestionAndAnswer.online.ransack(question_and_answer_ransack_params)
      @question_and_answers = @query.result
    end

    private

    def question_and_answer_ransack_params
      @question_and_answer_ransack_params ||= params[:q]&.permit(:question_or_answer_cont)
    end
  end
end
