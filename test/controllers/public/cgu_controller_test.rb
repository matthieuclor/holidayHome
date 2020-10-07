# frozen_string_literal: true

require 'test_helper'

module Public
  class CguControllerTest < ActionDispatch::IntegrationTest
    test "should get index" do
      get cgu_index_url
      assert_response :success
    end
  end
end
