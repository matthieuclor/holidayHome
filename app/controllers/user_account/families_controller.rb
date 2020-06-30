# frozen_string_literal: true

module UserAccount
  class FamiliesController < UserAccount::ApplicationController
    before_action :set_family, :check_creator, only: [:edit, :update, :destroy]

    def index
      @families = current_user.families
      @users = UserDecorator.wrap(User
        .with_attached_avatar
        .joins(:family_links)
        .where(family_links: { family_id: @families.pluck(:id) })
        .select("users.*, family_links.family_id as family_id")
      ).group_by(&:family_id)
    end

    def new
      @family = current_user.families.build
    end

    def create
      @family = current_user.families.build(
        family_params.merge(creator: current_user)
      )

      check_name_validity

      if @family.errors.empty? && @family.save
        add_family_to_current_user
        flash[:success] = "La famille a bien été créé"
        render js: "location.reload()"
      else
        flash[:error] = "Un problem est survenu lors de la creation de la famille"
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @family.update(family_params)
        flash[:success] = "La famille a bien été mise à jour"
        render js: "location.reload()"
      else
        flash[:error] = "Un problem est survenu lors de la mise à jour de la famille"
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      if @family.destroy
        remove_family_from_current_user
        flash[:success] = "La famille a bien été supprimée"
      else
        flash[:error] = "Un problem est survenu lors de la suppression de la famille"
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
      unless @family.creator == current_user
        flash[:error] = "Vous n'avez pas les droits pour modifier cette famille."

        respond_to do |format|
          format.html { redirect_to user_account_families_path }
          format.js { render js: "location.reload()" }
        end
      end
    end

    def check_name_validity
      family_names = current_user.families.pluck(:name).map(&:downcase)
      name = family_params[:name]&.downcase
      @family.errors.add(:name, :exclusion) if family_names.include?(name)
    end

    def add_family_to_current_user
      return if current_user.current_family_id
      current_user.update(current_family_id: @family.id)
    end

    def remove_family_from_current_user
      return unless current_user.current_family_id == @family.id

      if current_user.families.present?
        current_user.update(current_family_id: current_user.families.first.id)
      else
        current_user.update(current_family_id: nil)
      end
    end
  end
end
