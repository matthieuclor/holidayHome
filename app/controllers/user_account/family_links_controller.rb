# frozen_string_literal: true

module UserAccount
  class FamilyLinksController < UserAccount::ApplicationController
    before_action :set_family_link, :check_user

    def destroy
      if @family_link.destroy
        remove_family_from_current_user
        flash[:success] = t('.success')
      else
        flash[:error] = t('.error')
      end

      redirect_to user_account_families_path
    end

    private

    def set_family_link
      @family_link = FamilyLink.find(params[:id])
    end

    def check_user
      return if @family_link.user == current_user

      flash[:error] = t('.check_user.error')
      redirect_to user_account_families_path
    end

    def remove_family_from_current_user
      return unless current_user.current_family_id == @family_link.family_id

      if current_user.families.present?
        current_user.update(current_family: current_user.families.first)
      else
        current_user.update(current_family: nil)
      end
    end
  end
end
