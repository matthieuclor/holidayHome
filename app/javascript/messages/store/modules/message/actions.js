import axios from 'axios'
import qs from 'qs'

export default {
  getMessageItems({ commit }) {
    const bookingId = document.getElementById('messages-container')
      .getAttribute('data-booking-id')

    axios.get(`${bookingId}/messages.json`)
      .then((response) => commit('UPDATE_MESSAGE_ITEMS', response.data.messages))
  },
  createMessage({}, message) {
    const csrfToken = document.querySelector('[name=csrf-token]').content
    const bookingId = document.getElementById('messages-container')
      .getAttribute('data-booking-id')

    return new Promise((resolve, reject) => {
      axios(
        {
          method: 'post',
          url: `${bookingId}/messages.json`,
          data: qs.stringify({ message: { content: message } }),
          headers: { 'X-CSRF-TOKEN': csrfToken }
        }
      ).then(response => resolve(response)
      ).catch(error => reject(error))
    })
  }
}
