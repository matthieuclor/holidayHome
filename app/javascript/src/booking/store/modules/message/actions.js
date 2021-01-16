import axios from 'axios';
import qs from 'qs';

export default {
  getMessageItems({ commit }, { bookingId, page }) {
    return new Promise((resolve, reject) => {
      axios.get(`/user_account/bookings/${bookingId}/messages.json?page=${page}`)
        .then((response) => {
          commit('UPDATE_MESSAGE_ITEMS', response.data.messages);
          commit('UPDATE_MESSAGE_PAGY', response.data.messagePagy);
          resolve(response);
        }).catch((error) => reject(error));
    });
  },
  createMessage(_, { bookingId, message }) {
    const csrfToken = document.querySelector('[name=csrf-token]').content;

    return new Promise((resolve, reject) => {
      axios(
        {
          method: 'post',
          url: `${bookingId}/messages.json`,
          data: qs.stringify({ message: { content: message } }),
          headers: { 'X-CSRF-TOKEN': csrfToken },
        },
      ).then((response) => resolve(response)).catch((error) => reject(error));
    });
  },
  addMessageItem({ commit }, message) {
    commit('ADD_MESSAGE_ITEM', message);
  },
};
