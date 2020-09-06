import axios from 'axios'
import qs from 'qs'

export default {
  getMessageItems({ commit }, bookingId) {
    axios.get(`/user_account/bookings/${bookingId}/messages.json`)
    .then((response) => {
      commit('UPDATE_MESSAGE_ITEMS', response.data.messages)
    })
  },
  createMessage({}, { bookingId, message }) {
    const csrfToken = document.querySelector('[name=csrf-token]').content

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
  },
  addMessageItem({ commit }, message) {
    commit('ADD_MESSAGE_ITEM', message)
  }
}
