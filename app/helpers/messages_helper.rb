# frozen_string_literal: true

module MessagesHelper
  def message_class(user)
    if user == current_user
      "bg-primary float-right text-white"
    else
      "bg-light float-left"
    end
  end

  def message_text_class(user)
    if user == current_user
      "text-white"
    else
      "text-dark"
    end
  end
end
