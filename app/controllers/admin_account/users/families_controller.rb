# frozen_string_literal: true

module AdminAccount
  module Users
    class FamiliesController < AdminAccount::ApplicationController
      respond_to :js

      def index
        @pagy, @families = pagy(
          Family.joins(:family_links)
                .where(family_links: { user_id: params[:user_id] })
        )
      end
    end
  end
end
