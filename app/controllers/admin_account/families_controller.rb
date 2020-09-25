# frozen_string_literal: true

module AdminAccount
  class FamiliesController < AdminAccount::ApplicationController
    def index
      @query = Family.ransack(families_ransack_params)
      @pagy, @families = pagy(@query.result.distinct.joins(:users))
    end

    private

    def families_ransack_params
      @families_ransack_params ||= params[:q]&.permit(:name_cont)
    end
  end
end
