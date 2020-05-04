export default {
  UPDATE_VENUE_ITEMS(state, payload) {
    state.venueItems = payload
  },
  UPDATE_VENUE_ITEM(state, payload) {
    state.venueItem = payload
  },
  UPDATE_NEW_VENUE_ITEM(state, payload) {
    state.newVenueItem = payload
  },
  ADD_BEDROOM(state, payload) {
    state.newVenueItem.bedrooms.push(payload)
  },
  REMOVE_BEDROOM(state, index) {
    if (state.newVenueItem.bedrooms[index].id == null) {
      state.newVenueItem.bedrooms.splice(index, 1)
    } else {
      state.newVenueItem.bedrooms[index].Destroy = true
    }
  },
  ADD_BATHROOM(state, payload) {
    state.newVenueItem.bathrooms.push(payload)
  },
  REMOVE_BATHROOM(state, index) {
    if (state.newVenueItem.bathrooms[index].id == null) {
      state.newVenueItem.bathrooms.splice(index, 1)
    } else {
      state.newVenueItem.bathrooms[index].Destroy = true
    }
  },
}
