export default {
  UPDATE_VENUE_ITEMS(state, payload) {
    state.venueItems = payload;
  },
  UPDATE_CURRENT_VENUE(state, payload) {
    state.currentVenue = payload;
  },
};
