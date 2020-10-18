# frozen_string_literal: true

module AdminAccount
  class UsersController < AdminAccount::ApplicationController
    before_action :set_user, only: [:edit, :update]
    respond_to :js, :html

    def index
      @query = User.ransack(users_ransack_params)
      @pagy, @users = pagy(@query.result.includes(:avatar_attachment))
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
        flash[:success] = "L'utilisateur a bien été mise a jours"
        render js: "location.reload()"
      else
        flash[:error] = "Un problem est survenu lors de la mise à jour de l'utilisateur"
        render :edit
      end
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :phone, :address)
    end

    def users_ransack_params
      @users_ransack_params ||= params[:q]&.permit(
        :first_name_or_last_name_or_email_cont
      )
    end
  end
end
