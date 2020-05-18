import moment from 'moment'
import axios from 'axios'
import qs from 'qs'

export default {
  createBooking({ commit, dispatch }, range) {
    const csrfToken = document.querySelector('[name=csrf-token]').content
    const from = moment(range.start).format('YYYY-MM-DD HH:mm:ss')
    const to = moment(range.end).format('YYYY-MM-DD HH:mm:ss')

    return new Promise((resolve, reject) => {
      axios(
        {
          method: 'post',
          url: 'bookings.json',
          data: qs.stringify({ booking: { from: from, to: to } }),
          headers: { 'X-CSRF-TOKEN': csrfToken }
        }
      ).then(response => {
        commit('UPDATE_FLASHES', response.data.flashes)
        dispatch('getBookingItems')
        resolve(response)
      }).catch(error => {
        commit('UPDATE_FLASHES', error.response.data.flashes)
        reject(error)
      })
    })
  },
  getBookingItems({ commit }) {
    axios.get('bookings.json').then((response) => {
      commit('UPDATE_BOOKING_ITEMS', response.data.bookings)
    })
  }
}
