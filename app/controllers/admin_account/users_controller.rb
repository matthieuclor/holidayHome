# frozen_string_literal: true

module AdminAccount
  class UsersController < AdminAccount::ApplicationController
    before_action :user, only: %i(edit update)
    respond_to :js, :html

    def index
      @query = User.ransack(user_ransack_params)
      @pagy, @users = pagy(@query.result.with_attached_avatar)
      @users = UserDecorator.wrap(@users)
    end

    def show
      @user = UserDecorator.new(
        User.with_attached_avatar
            .includes(:families, :received_invitations)
            .find(params[:id])
      )
    end

    def edit
    end

    def update
      if @user.update(user_params)
        flash[:success] = t('.success')
        render js: 'location.reload()'
      else
        flash[:error] = t('.error')
        render :edit
      end
    end

    private

    def user
      @user ||= User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(
        :first_name,
        :last_name,
        :email,
        :phone,
        :address,
        :plan,
        :plan_deadline
      )
    end

    def user_ransack_params
      @user_ransack_params ||= params[:q]&.permit(
        :first_name_or_last_name_or_email_cont
      )
    end
  end
end
