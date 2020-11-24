# frozen_string_literal: true

class InvitationDecorator < ApplicationDecorator
  def out_of_limit_of_send?
    @out_of_limit_of_send ||= send_count >= Invitation::LIMIT_OF_SEND
  end

  def out_of_limit_of_send_date?
    return false unless last_send_at

    @out_of_limit_of_send_date ||=
      last_send_at + Invitation::LIMIT_OF_SEND_DATE >= DateTime.now
  end

  def resendable?
    @resendable ||= !out_of_limit_of_send? && !out_of_limit_of_send_date?
  end

  def sender_full_name
    @sender_full_name ||= "#{sender.first_name} #{sender.last_name}"
  end
end
