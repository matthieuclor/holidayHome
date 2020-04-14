# frozen_string_literal: true

require 'test_helper'

module UserAccount
  class FamiliesControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in users(:matthieu), scope: :user
    end

    test "redirected if not logged in" do
      sign_out :user
      get user_account_families_url
      assert_redirected_to new_user_session_url
    end

    test "should get index" do
      get user_account_families_url
      assert_response :success
    end

    test "should get new" do
      get new_user_account_family_url, xhr: true
      family = @controller.view_assigns["family"]

      assert_instance_of Family, family
      assert family.new_record?
      assert_response :success
    end

    test "should create family" do
      post user_account_families_url, params: { family: { name: 'test' } }, xhr: true
      assert_response :success
    end

    test "should get edit" do
      get edit_user_account_family_url(families(:legue)), xhr: true
      assert_response :success
    end

    test "should update family" do
      patch user_account_family_url(families(:legue)), params: { family: { name: 'test' } }, xhr: true
      assert_response :success
    end

    test "should destroy family" do
      delete user_account_family_url(families(:legue))
      assert_redirected_to user_account_families_url
    end
  end
end
