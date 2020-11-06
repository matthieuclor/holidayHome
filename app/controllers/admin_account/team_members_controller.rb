# frozen_string_literal: true

module AdminAccount
  class TeamMembersController < AdminAccount::ApplicationController
    respond_to :js, :html
    before_action :set_team_member, only: [:edit, :update, :destroy]

    def index
      @query = TeamMember.ransack(team_member_ransack_params)
      @pagy, @team_members = pagy(@query.result.with_attached_photo, items: 10)
      @team_members = TeamMemberDecorator.wrap(@team_members)
    end

    def new
      @team_member = TeamMember.new
    end

    def create
      @team_member = TeamMember.new(team_member_params)

      if @team_member.save
        flash[:success] = "Le mambre a bien été créé"
        render js: "location.reload()"
      else
        flash[:error] = "Un problem est survenu lors de la création du membre"
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @team_member.update(team_member_params)
        flash[:success] = "Le membre a bien été mise à jour"
        render js: "location.reload()"
      else
        flash[:error] = "Un problem est survenu lors de la mise à jour du membre"
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      if @team_member.destroy
        flash[:success] = "Le membre a bien été supprimée"
      else
        flash[:error] = "Un problem est survenu lors de la suppression du membre"
      end

      redirect_to admin_account_team_members_path
    end

    private

    def set_team_member
      @team_member = TeamMember.find(params[:id])
    end

    def team_member_params
      params.require(:team_member).permit(
        :first_name,
        :last_name,
        :function,
        :status,
        :photo
      )
    end

    def team_member_ransack_params
      @team_member_ransack_params ||= params[:q]&.permit(
        :first_name_or_last_name_or_function_cont,
        :status_eq
      )
    end
  end
end
