# frozen_string_literal: true

module AdminAccount
  class DesignSystemController < AdminAccount::ApplicationController

    def index
      @object_docs = DesignSystemFormObject.new(
        input: "input",
        input_disabled: "input",
        select: 1,
        select_disabled: 1,
        textarea: "Lorem Ipsum is simply dummy text of the printing and tfype...",
        textarea_disabled: "Lorem Ipsum is simply dummy text of the printing...",
        checkbox: true,
        checkbox_disabled: true,
        radio_button: true,
        radio_button_disabled: true,
        switch: true,
        switch_disabled: true
      )

      @object_docs.valid?
    end
  end
end
