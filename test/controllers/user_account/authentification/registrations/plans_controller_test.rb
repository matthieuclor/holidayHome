# frozen_string_literal: true

require 'test_helper'

module UserAccount
  module Authentification
    module Registrations
      class PlansControllerTest < ActionDispatch::IntegrationTest
        User.plans.each_key do |plan|
          test "should set #{plan} hutoki_plan into cookies without sign in" do
            post user_account_plans_url, params: { user: { plan: plan } }

            assert_equal cookies[:hutoki_plan], plan
            assert_redirected_to new_user_registration_url
          end

          test "should set #{plan} hutoki_plan into cookies with sign in" do
            sign_in users(:matthieu), scope: :user
            post user_account_plans_url, params: { user: { plan: plan } }

            assert_equal cookies[:hutoki_plan], plan
            assert_redirected_to new_user_registration_url
          end
        end
      end
    end
  end
end
