module UserAccount
  module Invitations
    class DisapprouvesController < UserAccount::ApplicationController
      def new
        redirect_to user_account_invitations_path
      end
    end
  end
end
