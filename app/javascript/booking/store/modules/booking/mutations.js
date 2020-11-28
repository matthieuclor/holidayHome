export default {
  UPDATE_BOOKING_ITEM(state, payload) {
    state.bookingItem = { ...state.bookingItem, ...payload };
  },
  UPDATE_BOOKING_CURRENT_USERS(state, payload) {
    state.bookingCurrentUsers = payload;
  },
};
