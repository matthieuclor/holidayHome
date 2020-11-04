# frozen_string_literal: true

require 'test_helper'

module Public
  class TeamMembersControllerTest < ActionDispatch::IntegrationTest
    test "should get online team members" do
      get team_members_url
      team_members = @controller.view_assigns["team_members"]
      assert_instance_of TeamMemberDecorator, team_members.first
      team_members.each { |team_member| assert team_member.online? }
      assert_response :success
    end
  end
end
