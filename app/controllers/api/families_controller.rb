# frozen_string_literal: true

module Api
  class FamiliesController < Api::ApplicationController
    def index
      @families = current_user.families
    end
  end
end
