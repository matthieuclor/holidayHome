export default {
  UPDATE_BOOKING_PENDING_ITEMS(state, payload) {
    state.bookingPendingItems = payload;
  },
  UPDATE_BOOKING_ITEMS(state, payload) {
    state.bookingItems = payload;
  },
  UPDATE_BOOKING_FORM_ITEMS(state, payload) {
    const date = new Date();
    const yesterday = date.setDate(date.getDate() - 1);
    state.bookingFormItems = payload.concat({ from: null, to: yesterday });
  },
  UPDATE_BOOKING_DATE_RANGE(state, payload) {
    state.bookingDateRange = payload;
  },
  UPDATE_BOOKING_MODAL_FORM(state, payload) {
    state.bookingModalForm = payload;
  },
};
