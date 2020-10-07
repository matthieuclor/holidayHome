# frozen_string_literal: true

require 'test_helper'

module Public
  class SitemapsControllerTest < ActionDispatch::IntegrationTest
    test "should get index" do
      get sitemaps_url
      assert_response :success
    end
  end
end
