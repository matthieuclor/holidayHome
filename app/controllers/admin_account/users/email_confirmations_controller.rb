module AdminAccount
  module Users
    class EmailConfirmationsController < AdminAccount::ApplicationController
      def update
        user = User.find(params[:user_id])

        if user.confirm
          flash[:success] = "L'email de #{user.first_name} a bien été confirmé"
        else
          flash[:error] = "Un problem est survenu lors de la confirmation de l'email"
        end

        redirect_back fallback_location: admin_account_users_path
      end
    end
  end
end
