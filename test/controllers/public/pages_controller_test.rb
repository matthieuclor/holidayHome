# frozen_string_literal: true

require 'test_helper'

module Public
  class PagesControllerTest < ActionDispatch::IntegrationTest
    test "should get main" do
      get root_url
      assert_response :success
    end
  end
end
