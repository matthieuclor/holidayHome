# frozen_string_literal: true

require 'test_helper'

module UserAccount
  class PlansControllerTest < ActionDispatch::IntegrationTest
    setup do
      @user = users(:matthieu)
      sign_in @user, scope: :user
    end

    test "redirected if not logged in" do
      sign_out @user
      get user_account_plans_url, xhr: true
      assert_response :redirect
    end

    test "should render plan" do
      get user_account_plans_url, xhr: true

      current_user = @controller.view_assigns["current_user"]

      assert_instance_of UserDecorator, current_user
      assert_equal current_user, @user
      assert_response :success
    end

    test "should render edit plan" do
      get edit_user_account_plans_url, xhr: true
      assert_response :success
    end

    test "should update user plan whith premium" do
      patch user_account_plans_url, xhr: true

      assert_equal @user.plan, "premium"
      assert_equal @user.plan_deadline, Date.current + 1.year
      assert_response :success
    end
  end
end
