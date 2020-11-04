# frozen_string_literal: true

module Public
  class TeamMembersController < ApplicationController
    def index
      @team_members = TeamMemberDecorator.wrap(TeamMember.online)
    end
  end
end
