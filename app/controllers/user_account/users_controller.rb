# frozen_string_literal: true

module UserAccount
  class UsersController < UserAccount::ApplicationController
    include CurrentFamily

    before_action :set_current_family, only: [:index]

    def index
      @pagy, @users = pagy(@current_family.users.with_attached_avatar, items: 10)
      @users = UserDecorator.wrap(@users)
    end

    def show
      if FamilyLink.where(user_id: params[:id],
                          family_id: current_user.current_family_id).present?

        @user = UserDecorator.new(User.with_attached_avatar.find(params[:id]))
      else
        flash[:error] = "Vous n'êtes pas censé voir cet utilisateur"
        render js: "location.reload()", status: :unauthorized
      end
    end
  end
end
