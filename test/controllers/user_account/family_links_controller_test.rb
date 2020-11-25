# frozen_string_literal: true

require 'test_helper'

module UserAccount
  class FamilyLinksControllerTest < ActionDispatch::IntegrationTest
    setup do
      @user = users(:matthieu)
      @family_link = family_links(:matthieu_clor)
      @family = families(:clor)
    end

    test 'should remove family link from user' do
      sign_in @user, scope: :user
      delete user_account_family_link_url(@family_link)
      assert_not @user.families.include?(@family)
      assert_not_equal @user.current_family_id, @family.id
      assert_redirected_to user_account_families_url
    end

    test 'redirected if not logged in' do
      delete user_account_family_link_url(@family_link)
      assert @user.families.include?(@family)
      assert_equal @user.current_family_id, @family.id
      assert_redirected_to new_user_session_url
    end
  end
end
