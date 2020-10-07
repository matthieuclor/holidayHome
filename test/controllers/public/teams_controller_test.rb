# frozen_string_literal: true

require 'test_helper'

module Public
  class TeamsControllerTest < ActionDispatch::IntegrationTest
    test "should get index" do
      get teams_url
      assert_response :success
    end
  end
end
