# frozen_string_literal: true

module AdminAccount
  class TeamMembersController < AdminAccount::ApplicationController
    respond_to :js, :html
    before_action :team_member, only: %i(edit update destroy)

    def index
      @query = TeamMember.ransack(team_member_ransack_params)
      @pagy, @team_members = pagy(@query.result.with_attached_photo, items: 10)
      @team_members = TeamMemberDecorator.wrap(@team_members)
    end

    def new
      @team_member = TeamMember.new
    end

    def edit
    end

    def create
      @team_member = TeamMember.new(team_member_params)

      if @team_member.save
        flash[:success] = t('.success')
        render js: 'location.reload()'
      else
        flash[:error] = t('.error')
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @team_member.update(team_member_params)
        flash[:success] = t('.success')
        render js: 'location.reload()'
      else
        flash[:error] = t('.error')
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      if @team_member.destroy
        flash[:success] = t('.success')
      else
        flash[:error] = t('.error')
      end

      redirect_to admin_account_team_members_path
    end

    private

    def team_member
      @team_member ||= TeamMember.find(params[:id])
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
