# frozen_string_literal: true

class DesignSystemFormObject < ApplicationFormObject
  attr_accessor :input, :input_disabled, :input_required, :select, :select_disabled,
                :select_required, :textarea, :textarea_disabled, :textarea_required,
                :checkbox, :checkbox_disabled, :checkbox_required, :checkboxes_ids,
                :radio_button, :radio_button_disabled, :radio_button_required,
                :switch, :switch_disabled, :switch_required

  validates :input_required,
            :select_required,
            :textarea_required,
            :checkbox_required,
            :radio_button_required,
            :switch_required,
            presence: true

  def initialize(args = {})
    super()

    %i(input select textarea checkbox radio_button switch).each do |attr|
      instance_variable_set("@#{attr}", args[attr])
      instance_variable_set("@#{attr}_disabled", args[:"#{attr}_disabled"])
      instance_variable_set("@#{attr}_required", args[:"#{attr}_required"])
    end
  end
end
