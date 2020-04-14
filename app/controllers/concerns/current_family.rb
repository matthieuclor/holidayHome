# frozen_string_literal: true

module CurrentFamily
  extend ActiveSupport::Concern

  included do
    def set_current_family
      @current_family = Family.find_by(id: current_user.current_family_id)

      unless @current_family.present?
        current_user.update(current_family_id: current_user.families.first.id)
        set_current_family
      end
    end
  end
end
