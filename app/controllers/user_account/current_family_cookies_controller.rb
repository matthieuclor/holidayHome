module UserAccount
  class CurrentFamilyCookiesController < UserAccount::ApplicationController
    def update
      cookies.permanent[:current_family_id] = current_family_cookies_params[:id]
      redirect_back fallback_location: user_account_dashboards_path
    end

    private

    def current_family_cookies_params
      params.require(:current_family_cookies).permit(:id)
    end
  end
end
