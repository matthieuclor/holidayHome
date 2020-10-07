# frozen_string_literal: true

require 'test_helper'

module Public
  class CareersControllerTest < ActionDispatch::IntegrationTest
    test "should get index" do
      get careers_url
      assert_response :success
    end
  end
end
