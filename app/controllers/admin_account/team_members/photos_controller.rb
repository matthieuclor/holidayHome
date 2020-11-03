# frozen_string_literal: true

module AdminAccount
  module TeamMembers
    class PhotosController < AdminAccount::ApplicationController
      respond_to :js

      def destroy
        @team_member = TeamMember.find(params[:team_member_id])
        @team_member.photo.purge
      end
    end
  end
end
