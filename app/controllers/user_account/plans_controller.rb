# frozen_string_literal: true

module UserAccount
  class PlansController < UserAccount::ApplicationController
    respond_to :js, :html

    def show
      @current_user = UserDecorator.new(current_user)
    end

    def edit
    end

    def update
      if current_user.update(plan: :premium, plan_deadline: Date.current + 1.year)
        flash[:success] = 'Le plan a bien été mise à jour'
        render js: 'location.reload()'
      else
        flash[:error] = 'Un problem est survenu lors de la mise a jour du plan'
        render :edit, status: :unprocessable_entity
      end
    end
  end
end
