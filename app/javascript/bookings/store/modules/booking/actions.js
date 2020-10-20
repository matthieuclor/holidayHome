import moment from 'moment'
import axios from 'axios'
import qs from 'qs'

export default {
  getBookingPendingItems({ commit }) {
    axios.get('bookings/pending.json')
    .then((response) => commit('UPDATE_BOOKING_PENDING_ITEMS', response.data.pendingBookings))
  },
  getBookingItems({ commit }, calendar) {
    axios.get('bookings/range.json', { params: { ...calendar } })
    .then((response) => commit('UPDATE_BOOKING_ITEMS', response.data.bookings))
  },
  getBookingFormItems({ commit }, calendar) {
    axios.get('bookings/range.json', { params: { ...calendar } })
    .then((response) => commit('UPDATE_BOOKING_FORM_ITEMS', response.data.bookings))
  },
  updateBookingDateRange({ commit }, dateRange) {
    commit('UPDATE_BOOKING_DATE_RANGE', dateRange)
  },
  updateBookingModalForm({ commit }, value) {
    commit('UPDATE_BOOKING_MODAL_FORM', value)
  },
  createBooking({ commit, dispatch }, { start, end, minDate, maxDate, message }) {
    const csrfToken = document.querySelector('[name=csrf-token]').content
    const from = moment(start).format('YYYY-MM-DD HH:mm:ss')
    const to = moment(end).format('YYYY-MM-DD HH:mm:ss')

    return new Promise((resolve, reject) => {
      axios(
        {
          method: 'post',
          url: 'bookings.json',
          data: qs.stringify({
            booking: {
              from: from,
              to: to,
              messages_attributes: [{ content: message }]
            }
          }),
          headers: { 'X-CSRF-TOKEN': csrfToken }
        }
      ).then(response => {
        commit('UPDATE_FLASHES', response.data.flashes)
        commit('UPDATE_PLAN_ERROR', null)
        dispatch('getBookingItems', { minDate, maxDate })
        commit('UPDATE_BOOKING_MODAL_FORM', false)
        resolve(response)
      }).catch(error => {
        commit('UPDATE_FLASHES', error.response.data.flashes)
        commit('UPDATE_PLAN_ERROR', error.response.data.planError)
        commit('UPDATE_BOOKING_MODAL_FORM', false)
        reject(error)
      })
    })
  }
}
