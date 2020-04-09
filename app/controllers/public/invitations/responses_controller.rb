module Public
  module Invitations
    class ResponsesController < ApplicationController
      def new
        # invitation = Invitation.find_by(token: response_params[:token])
        redirect_to user_account_sended_invitations_path
      end

      private

      def response_params
        params.require(:response).permit(:status, :token)
      end
    end
  end
end
