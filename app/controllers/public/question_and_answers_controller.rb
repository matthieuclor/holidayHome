# frozen_string_literal: true

module Public
  class QuestionAndAnswersController < ApplicationController
    def index
      @question_and_answers = QuestionAndAnswer.online
    end
  end
end
