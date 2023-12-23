# frozen_string_literal: true

module AdminAccount
  class AdminsController < AdminAccount::ApplicationController
    include Pagy::Backend

    respond_to :js, :html

    def index
      @query = Admin.ransack(admin_ransack_params)
      @pagy, @admins = pagy(@query.result)
      @admins = AdminDecorator.wrap(@admins)
    end

    private

    def admin_ransack_params
      @admin_ransack_params ||= params[:q]&.permit(
        :first_name_or_last_name_or_email_cont
      )
    end
  end
end
