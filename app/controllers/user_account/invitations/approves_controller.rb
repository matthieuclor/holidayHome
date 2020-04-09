module UserAccount
  module Invitations
    class ApprovesController < UserAccount::ApplicationController
      def new
        redirect_to redirect_to user_account_invitations_path
      end
    end
  end
end
