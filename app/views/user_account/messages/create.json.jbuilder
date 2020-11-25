# frozen_string_literal: true

json.error @message.errors.full_messages.first unless @message.valid?
