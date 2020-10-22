# frozen_string_literal: true

require 'test_helper'

module UserAccount
  class FamiliesControllerTest < ActionDispatch::IntegrationTest
    setup do
      @user = users(:matthieu)
      sign_in @user, scope: :user
    end

    test "redirected if not logged in" do
      sign_out :user
      get user_account_families_url
      assert_redirected_to new_user_session_url
    end

    test "should get index" do
      get user_account_families_url

      families = @controller.view_assigns["families"]

      assert_instance_of FamilyDecorator, families.first
      families.each { |family| assert family.users.include?(@user) }
      assert_response :success
    end

    test "should get new" do
      get new_user_account_family_url, xhr: true
      family = @controller.view_assigns["family"]

      assert_instance_of Family, family
      assert family.new_record?
      assert_response :success
    end

    test "should not create family with basic plan" do
      post user_account_families_url, params: { family: { name: 'test', days_for_approval: 15 } }, xhr: true
      assert_response :unprocessable_entity
    end

    test "should create only one family with basic plan" do
      sign_out :user
      sign_in users(:bryan), scope: :user
      post user_account_families_url, params: { family: { name: 'test', days_for_approval: 15 } }, xhr: true
      assert_response :success
    end

    test "should create family with premium plan" do
      @user.premium!
      post user_account_families_url, params: { family: { name: 'test2', days_for_approval: 15 } }, xhr: true
      assert_response :success
    end

    test "should get edit" do
      get edit_user_account_family_url(families(:legue)), xhr: true
      assert_response :success
    end

    test "should update family" do
      patch user_account_family_url(families(:legue)), params: { family: { name: 'test3' } }, xhr: true
      assert_response :success
    end

    test "should not update family with existing name" do
      patch user_account_family_url(families(:legue)), params: { family: { name: 'clor' } }, xhr: true
      assert_response :unprocessable_entity
    end

    test "should destroy family" do
      delete user_account_family_url(families(:legue))
      assert_redirected_to user_account_families_url
    end
  end
end
