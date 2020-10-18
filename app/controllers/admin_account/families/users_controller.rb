# frozen_string_literal: true

module AdminAccount
  module Families
    class UsersController < AdminAccount::ApplicationController
      respond_to :js

      def index
        @pagy, @users = pagy(
          User.joins(:family_links)
              .where(family_links: { family_id: params[:family_id] })
              .with_attached_avatar)

        @users = UserDecorator.wrap(@users)
      end
    end
  end
end
