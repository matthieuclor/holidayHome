# frozen_string_literal: true

module AdminAccount
  class QuestionAndAnswersController < AdminAccount::ApplicationController
    respond_to :js, :html
    before_action :question_and_answer, only: %i(show edit update destroy)

    def index
      @query = QuestionAndAnswer.ransack(question_and_answer_ransack_params)
      @pagy, @question_and_answers = pagy(@query.result)
    end

    def show
    end

    def new
      @question_and_answer = QuestionAndAnswer.new
    end

    def edit
    end

    def create
      @question_and_answer = QuestionAndAnswer.new(question_and_answer_params)

      if @question_and_answer.save
        flash[:success] = t('.success')
        render js: 'location.reload()'
      else
        flash[:error] = t('.error')
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @question_and_answer.update(question_and_answer_params)
        flash[:success] = t('.success')
        render js: 'location.reload()'
      else
        flash[:error] = t('.error')
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      if @question_and_answer.destroy
        flash[:success] = t('.success')
        redirect_to admin_account_question_and_answers_path
      else
        flash[:error] = t('.error')
        render :show
      end
    end

    private

    def question_and_answer
      @question_and_answer ||= QuestionAndAnswer.find(params[:id])
    end

    def question_and_answer_params
      params.require(:question_and_answer).permit(:question, :answer)
    end

    def question_and_answer_ransack_params
      @question_and_answer_ransack_params ||= params[:q]&.permit(:question_or_answer_cont, :status_eq)
    end
  end
end
