# frozen_string_literal: true

module CurrentFamily
  extend ActiveSupport::Concern

  included do
    def set_current_family
      @current_family = current_user.current_family

      unless @current_family.present?
        if current_family = current_user.families.first
          current_user.update(current_family: current_family)
          set_current_family
        end
      end
    end
  end
end
