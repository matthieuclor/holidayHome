class InvitationDecorator < ApplicationDecorator
  def is_resendable?
    send_count <= Invitation::LIMIT_OF_SEND &&
    (last_send_at || DateTime.now) + Invitation::LIMIT_OF_SEND_DATE <= DateTime.now
  end
end
