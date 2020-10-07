# frozen_string_literal: true

require 'test_helper'

module Public
  class PrivacyPolicyControllerTest < ActionDispatch::IntegrationTest
    test "should get index" do
      get privacy_policy_index_url
      assert_response :success
    end
  end
end
