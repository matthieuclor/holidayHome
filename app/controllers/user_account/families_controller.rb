module UserAccount
  class FamiliesController < UserAccount::ApplicationController
    def new
      @family = current_user.families.build
    end

    def create
      @family = current_user.families.create(family_params)

      if @family.persisted?
        flash[:success] = "La famille a bien été créé"
      else
        flash[:error] = "Un problem est survenu lors de la creation de la famille"
        render :new
      end
    end

    private

    def family_params
      params.require(:family).permit(:name)
    end
  end
end
