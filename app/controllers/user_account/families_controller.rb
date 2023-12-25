# frozen_string_literal: true

module UserAccount
  class FamiliesController < UserAccount::ApplicationController
    include SkipBullet

    before_action :set_family, :check_creator, only: %i(edit update destroy)
    around_action :skip_bullet, only: :index

    def index
      @families = FamilyDecorator.wrap(current_user.families)
      @users = UserDecorator.wrap(
        User.with_attached_avatar
            .joins(:family_links)
            .where(family_links: { family_id: @families.pluck(:id) })
            .select('users.*, family_links.family_id as family_id')
      ).group_by(&:family_id)
    end

    def new
      @family = current_user.families.build
    end

    def edit
    end

    def create
      @family = current_user.families.build(
        family_params.merge(creator: current_user)
      )

      if check_name_validity && @family.save
        add_family_to_current_user
        flash[:success] = t('.success')
        render js: 'location.reload()'
      else
        @plan_error = @family.errors[:base].first
        flash[:error] = @plan_error || t('.error')
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @family.update(family_params)
        flash[:success] = t('.success')
        render js: 'location.reload()'
      else
        flash[:error] = t('.error')
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      if @family.destroy
        remove_family_from_current_user
        flash[:success] = t('.success')
      else
        flash[:error] = t('.error')
      end

      redirect_to user_account_families_path
    end

    private

    def family_params
      params.require(:family).permit(:name, :days_for_approval)
    end

    def set_family
      @family = Family.find(params[:id])
    end

    def check_creator
      return if @family.creator == current_user

      flash[:error] = "Vous n'avez pas les droits pour modifier cette famille."

      respond_to do |format|
        format.html { redirect_to user_account_families_path }
        format.js { render js: 'location.reload()' }
      end
    end

    def check_name_validity
      family_names = current_user.families.pluck(:name).map(&:downcase)
      name = family_params[:name]&.downcase
      @family.errors.add(:name, :exclusion) if family_names.include?(name)
      @family.errors.empty?
    end

    def add_family_to_current_user
      return if current_user.current_family_id

      current_user.update(current_family: @family)
    end

    def remove_family_from_current_user
      return unless current_user.current_family_id == @family.id

      if current_user.families.present?
        current_user.update(current_family: current_user.families.first)
      else
        current_user.update(current_family: nil)
      end
    end
  end
end
