class InvitationDecorator < ApplicationDecorator
  def is_out_of_limit_of_send?
    send_count >= Invitation::LIMIT_OF_SEND
  end

  def is_out_of_limit_of_send_date?
    return false unless last_send_at
    last_send_at + Invitation::LIMIT_OF_SEND_DATE >= DateTime.now
  end

  def is_resendable?
    !is_out_of_limit_of_send? && !is_out_of_limit_of_send_date?
  end

  def sender_full_name
    "#{sender.first_name} #{sender.last_name}"
  end
end
