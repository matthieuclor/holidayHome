module UserAccount
  class FamiliesController < UserAccount::ApplicationController
    before_action :set_family, only: [:edit, :update, :destroy]

    def index
      @families = current_user
        .families
        .joins(:family_links)
        .select("families.*, COUNT(family_links.user_id) as users_count")
        .group('families.id')
    end

    def new
      @family = current_user.families.build
    end

    def create
      @family = current_user.families.build(family_params)

      check_name_validity

      if @family.errors.empty? && @family.save
        current_user.family_created! if current_user.account_created?
        flash[:success] = "La famille a bien été créé"
        render js: "location.reload()"
      else
        flash[:error] = "Un problem est survenu lors de la creation de la famille"
        render :new
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
        render :edit
      end
    end

    def destroy
      if @family.destroy
        flash[:success] = "La famille a bien été supprimée"
      else
        flash[:error] = "Un problem est survenu lors de la suppression de la famille"
      end

      redirect_to user_account_families_path
    end

    private

    def family_params
      params.require(:family).permit(:name)
    end

    def set_family
      @family = Family.find(params[:id])
    end

    def check_name_validity
      family_names = current_user.families.pluck(:name).map(&:downcase)
      name = family_params[:name]&.downcase
      @family.errors.add(:name, :exclusion) if family_names.include?(name)
    end
  end
end
