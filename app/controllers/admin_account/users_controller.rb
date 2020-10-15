# frozen_string_literal: true

module AdminAccount
  class UsersController < AdminAccount::ApplicationController
    def index
      @query = User.ransack(users_ransack_params)
      @pagy, @users = pagy(@query.result.includes(:avatar_attachment))
      @users = UserDecorator.wrap(@users)
    end

    def show
      @user = User.find(params[:id])
    end

    private

    def users_ransack_params
      @users_ransack_params ||= params[:q]&.permit(
        :first_name_or_last_name_or_email_cont
      )
    end
  end
end
