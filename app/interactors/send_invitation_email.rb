class SendInvitationEmail
  include Interactor

  before do
    @invitation = InvitationDecorator.new(context.invitation)

    context.fail!(error: "L'invitation doit être presente") unless @invitation.present?


    if @invitation.is_out_of_limit_of_send?
      context.fail!(error: "L'envoi d'invitation a atteint son quota de #{Invitation::LIMIT_OF_SEND}")
    end

    if @invitation.is_out_of_limit_of_send_date?
      context.fail!(error: "Une durée de #{Invitation::LIMIT_OF_SEND_DATE / 3600} heures est nécessaire entre chaque envoie")
    end
  end

  def call
    known_user = User.find_by(email: @invitation.email)

    if known_user
      UserMailer.send_to_known_user(context.invitation, known_user).deliver_later
    else
      UserMailer.send_to_unknown_user(context.invitation).deliver_later
    end
  end

  after do
    @invitation.update(last_send_at: DateTime.now, send_count: (@invitation.send_count + 1))
  end
end
