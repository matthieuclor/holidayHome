class InvitationDecorator < ApplicationDecorator
  def is_out_of_limit_of_send?
    send_count >= Invitation::LIMIT_OF_SEND
  end

  def is_out_of_limit_of_send_date?
    (last_send_at || DateTime.now) + Invitation::LIMIT_OF_SEND_DATE >= DateTime.now
  end

  def is_resendable?
    !is_out_of_limit_of_send? && !is_out_of_limit_of_send_date?
  end
end
