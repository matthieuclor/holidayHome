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
        flash[:success] = t('.success')
        render js: 'location.reload()'
      else
        flash[:error] = t('.error')
        render :edit, status: :unprocessable_entity
      end
    end
  end
end
