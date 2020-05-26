export default {
  UPDATE_BOOKING_ITEMS(state, payload) {
    state.bookingItems = payload
  },
  UPDATE_BOOKING_FORM_ITEMS(state, payload) {
    const date = new Date()
    const yesterday = date.setDate(date.getDate() - 1)
    state.bookingFormItems = payload.concat({ from: null, to: yesterday })
  }
}
