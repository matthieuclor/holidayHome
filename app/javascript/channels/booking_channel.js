
import consumer from "./consumer"


document.addEventListener('turbolinks:load', () => {
  const element = document.getElementById('messages')

  if (element) {
    const bookingId = element.getAttribute('data-booking-id')

    consumer.subscriptions.create({ channel: "BookingChannel", booking_id: bookingId }, {
      connected() {
      },
      disconnected() {
      },
      received(data) {
        element.innerHTML = data['message'] + element.innerHTML
      }
    })
  }
})
