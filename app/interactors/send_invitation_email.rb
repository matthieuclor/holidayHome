class SendInvitationEmail
  include Interactor

  before do
    context.fail!(error: "L'invitation doit être presente") unless context.invitation

    if context.invitation.send_count >= Invitation::LIMIT_OF_SEND
      context.fail!(error: "L'envoie d'invitation a atteint son quota de #{Invitation::LIMIT_OF_SEND}")
    end

    if (context.invitation.last_send_at || DateTime.now) + Invitation::LIMIT_OF_SEND_DATE >= DateTime.now
      context.fail!(error: "Une durée de #{Invitation::LIMIT_OF_SEND_DATE / 3600} heures est nécessaire entre chaque envoie")
    end
  end

  def call
    known_user = User.find_by(email: context.invitation.email)

    if known_user.present?
      UserMailer.send_to_known_user(context.invitation, known_user).deliver_later
      context.invitation.awaiting_acceptance!
    else
      UserMailer.send_to_unknown_user(context.invitation).deliver_later
      context.invitation.awaiting_creation!
    end
  end

  after do
    context.invitation.update(
      last_send_at: DateTime.now,
      send_count: (context.invitation.send_count + 1)
    )
  end
end
