# frozen_string_literal: true

module AdminAccount
  class QuestionAndAnswersController < AdminAccount::ApplicationController
    respond_to :js, :html
    before_action :set_question_and_answer, only: [:show, :edit, :update, :destroy]

    def index
      @query = QuestionAndAnswer.ransack(question_and_answer_ransack_params)
      @pagy, @question_and_answers = pagy(@query.result)
    end

    def show
    end

    def new
      @question_and_answer = QuestionAndAnswer.new
    end

    def create
      @question_and_answer = QuestionAndAnswer.new(question_and_answer_params)

      if @question_and_answer.save
        flash[:success] = "La faq a bien été créé"
        render js: "location.reload()"
      else
        flash[:error] = "Un problem est survenu lors de la création de la faq"
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @question_and_answer.update(question_and_answer_params)
        flash[:success] = "La faq a bien été mise à jour"
        render js: "location.reload()"
      else
        flash[:error] = "Un problem est survenu lors de la mise à jour de la faq"
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      if @question_and_answer.destroy
        flash[:success] = "La faq a bien été supprimée"
        redirect_to admin_account_question_and_answers_path
      else
        flash[:error] = "Un problem est survenu lors de la suppression de la faq"
        render :show
      end
    end

    private

    def set_question_and_answer
      @question_and_answer = QuestionAndAnswer.find(params[:id])
    end

    def question_and_answer_params
      params.require(:question_and_answer).permit(:question, :answer)
    end

    def question_and_answer_ransack_params
      @question_and_answer_ransack_params ||= params[:q]&.permit(:question_or_answer_cont, :status_eq)
    end
  end
end
