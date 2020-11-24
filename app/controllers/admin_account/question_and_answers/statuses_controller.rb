# frozen_string_literal: true

module AdminAccount
  module QuestionAndAnswers
    class StatusesController < AdminAccount::ApplicationController
      respond_to :js

      def update
        @question_and_answer = QuestionAndAnswer.find(params[:question_and_answer_id])

        if @question_and_answer.update(question_and_answer_params)
          flash[:success] = 'La faq a bien été mis à jour'
          render js: 'location.reload()'
        else
          flash[:error] = 'Un problem est survenu lors de la mise à jour de la faq'
          render :update, status: :unprocessable_entity
        end
      end

      private

      def question_and_answer_params
        params.require(:question_and_answer).permit(:status)
      end
    end
  end
end
