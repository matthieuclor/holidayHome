export default {
  UPDATE_VENUE_ITEMS(state, payload) {
    state.venueItems = payload
  },
  UPDATE_CURRENT_VENUE_ID(state, payload) {
    state.currentVenueId = payload
  }
}
