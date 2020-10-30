# frozen_string_literal: true

module AdminAccount
  class FamiliesController < AdminAccount::ApplicationController
    before_action :set_family, only: [:edit, :update]
    respond_to :js, :html

    def index
      @query = Family.ransack(families_ransack_params)
      @pagy, @families = pagy(@query.result.joins(:users, :creator))
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
        flash[:success] = "La famille a bien été mise a jours"
        render js: "location.reload()"
      else
        flash[:error] = "Un problem est survenu lors de la mise à jour de la famille"
        render :edit
      end
    end

    private

    def set_family
      @family = Family.find(params[:id])
    end

    def family_params
      params.require(:family).permit(:name, :days_for_approval)
    end

    def families_ransack_params
      @families_ransack_params ||= params[:q]&.permit(:name_cont)
    end
  end
end
