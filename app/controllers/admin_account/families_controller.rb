# frozen_string_literal: true

module AdminAccount
  class FamiliesController < AdminAccount::ApplicationController
    before_action :family, only: %i(edit update)
    respond_to :js, :html

    def index
      @query = Family.ransack(family_ransack_params)
      @pagy, @families = pagy(@query.result.joins(:users, :creator).distinct)
      @families = FamilyDecorator.wrap(@families)
    end

    def show
      @family = FamilyDecorator.new(
        Family.joins(:creator).includes(:users).find(params[:id])
      )
    end

    def edit
    end

    def update
      if @family.update(family_params)
        flash[:success] = t('.success')
        render js: 'location.reload()'
      else
        flash[:error] = t('.error')
        render :edit
      end
    end

    private

    def family
      @family ||= Family.find(params[:id])
    end

    def family_params
      params.require(:family).permit(:name, :days_for_approval)
    end

    def family_ransack_params
      @family_ransack_params ||= params[:q]&.permit(:name_cont)
    end
  end
end
