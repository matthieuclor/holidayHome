# frozen_string_literal: true

require 'test_helper'

module Public
  class PagesControllerTest < ActionDispatch::IntegrationTest
    test "should get main" do
      get root_url
      assert_response :success
    end

    test "should get about" do
      get about_url
      assert_response :success
    end

    test "should get pricing" do
      get pricing_url
      assert_response :success
    end

    test "should get teams" do
      get teams_url
      assert_response :success
    end

    test "should get faq" do
      get faq_url
      assert_response :success
    end

    test "should get cgu" do
      get cgu_url
      assert_response :success
    end

    test "should get privacy_policy" do
      get privacy_policy_url
      assert_response :success
    end

    test "should get company_details" do
      get company_details_url
      assert_response :success
    end

    test "should get sitemap" do
      get sitemap_url
      assert_response :success
    end
  end
end
