# frozen_string_literal: true

require 'test_helper'

module Public
  class RgpdCookiesControllerTest < ActionDispatch::IntegrationTest
    test 'should set accepted hutoki_rgpd into cookies' do
      post rgpd_cookies_url, xhr: true

      assert_equal cookies[:hutoki_rgpd], 'accepted'
      assert_response :success
    end
  end
end
