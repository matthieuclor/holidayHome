# frozen_string_literal: true

require 'test_helper'

module Public
  class CompanyDetailsControllerTest < ActionDispatch::IntegrationTest
    test "should get index" do
      get company_details_url
      assert_response :success
    end
  end
end
