# frozen_string_literal: true

require 'test_helper'

module Public
  class BlogControllerTest < ActionDispatch::IntegrationTest
    test "should get index" do
      get articles_url
      assert_response :success
    end
  end
end
