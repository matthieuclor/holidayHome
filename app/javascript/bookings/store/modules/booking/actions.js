import moment from 'moment'
import axios from 'axios'
import qs from 'qs'

export default {
  getBookingItems({ commit }, calendar) {
    axios.get('bookings.json', { params: { ...calendar } })
    .then((response) => commit('UPDATE_BOOKING_ITEMS', response.data.bookings))
  },
  createBooking({ commit, dispatch }, { start, end, minDate, maxDate }) {
    const csrfToken = document.querySelector('[name=csrf-token]').content
    const from = moment(start).format('YYYY-MM-DD HH:mm:ss')
    const to = moment(end).format('YYYY-MM-DD HH:mm:ss')

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
        dispatch('getBookingItems', { minDate, maxDate })
        resolve(response)
      }).catch(error => {
        commit('UPDATE_FLASHES', error.response.data.flashes)
        reject(error)
      })
    })
  }
}
