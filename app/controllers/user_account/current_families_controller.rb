module UserAccount
  class CurrentFamiliesController < UserAccount::ApplicationController
    def update
      current_user.update(current_family_id: current_family_params[:id])
      redirect_back fallback_location: user_account_dashboards_path
    end

    private

    def current_family_params
      params.require(:current_family).permit(:id)
    end
  end
end
