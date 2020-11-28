import axios from 'axios';
import qs from 'qs';

export default {
  getBookingItem({ commit }, bookingId) {
    axios.get(`/user_account/bookings/${bookingId}.json`)
      .then((response) => {
        commit('UPDATE_BOOKING_ITEM', response.data.booking);
        commit('UPDATE_BOOKING_APPROVAL_ITEMS', response.data.bookingApprovals);
      });
  },
  updateBookingStatus({ commit }, { bookingId, status }) {
    const csrfToken = document.querySelector('[name=csrf-token]').content;

    axios(
      {
        method: 'put',
        url: `/user_account/bookings/status/${bookingId}.json`,
        data: qs.stringify({ booking: { status } }),
        headers: { 'X-CSRF-TOKEN': csrfToken },
      },
    ).then((response) => {
      commit('UPDATE_FLASHES', response.data.flashes);
      commit('UPDATE_BOOKING_ITEM', response.data.booking);
      commit('UPDATE_BOOKING_APPROVAL_ITEMS', response.data.bookingApprovals);
    }).catch((error) => {
      commit('UPDATE_FLASHES', error.response.data.flashes);
    });
  },
  updateBookingCurrentUsers({ commit }, value) {
    commit('UPDATE_BOOKING_CURRENT_USERS', value);
  },
};
