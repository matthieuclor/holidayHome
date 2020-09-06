export default {
  UPDATE_BOOKING_ITEM(state, payload) {
    state.bookingItem = { ...state.bookingItem, ...payload }
  }
}
