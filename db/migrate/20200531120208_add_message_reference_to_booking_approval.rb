# frozen_string_literal: true

class AddMessageReferenceToBookingApproval < ActiveRecord::Migration[6.0]
  def change
    add_reference :booking_approvals, :message, index: true
  end
end
