# frozen_string_literal: true

require 'test_helper'

module Public
  class PricingControllerTest < ActionDispatch::IntegrationTest
    test "should get index" do
      get pricing_index_url
      assert_response :success
    end
  end
end
