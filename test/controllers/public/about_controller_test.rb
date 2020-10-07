# frozen_string_literal: true

require 'test_helper'

module Public
  class AboutControllerTest < ActionDispatch::IntegrationTest
    test "should get index" do
      get about_index_url
      assert_response :success
    end
  end
end
