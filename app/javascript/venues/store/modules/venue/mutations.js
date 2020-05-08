export default {
  UPDATE_VENUE_ITEMS(state, payload) {
    state.venueItems = payload
  },
  UPDATE_VENUE_PAGY(state, payload) {
    state.venuePagy = payload
  },
  UPDATE_VENUE_ITEM(state, payload) {
    state.venueItem = payload
  },
  UPDATE_FORM_VENUE_ITEM(state, payload) {
    state.venueFormItem = payload
  },
  UPDATE_FORM_VENUE_OWNER_ITEMS(state, payload) {
    state.venueOwnerFormItems = payload
  },
  ADD_TO_VENUE_ITEMS(state, payload) {
    state.venueItems.push(payload)
  },
  ADD_KEY(state, payload) {
    state.venueFormItem.keys.push(payload)
  },
  REMOVE_KEY(state, index) {
    if (state.venueFormItem.keys[index].id == null) {
      state.venueFormItem.keys.splice(index, 1)
    } else {
      state.venueFormItem.keys[index].Destroy = true
    }
  },
  ADD_NETWORK(state, payload) {
    state.venueFormItem.networks.push(payload)
  },
  REMOVE_NETWORK(state, index) {
    if (state.venueFormItem.networks[index].id == null) {
      state.venueFormItem.networks.splice(index, 1)
    } else {
      state.venueFormItem.networks[index].Destroy = true
    }
  },
  ADD_DIGITAL_CODE(state, payload) {
    state.venueFormItem.digitalCodes.push(payload)
  },
  REMOVE_DIGITAL_CODE(state, index) {
    if (state.venueFormItem.digitalCodes[index].id == null) {
      state.venueFormItem.digitalCodes.splice(index, 1)
    } else {
      state.venueFormItem.digitalCodes[index].Destroy = true
    }
  },
  ADD_HOME_SERVICE(state, payload) {
    state.venueFormItem.homeServices.push(payload)
  },
  REMOVE_HOME_SERVICE(state, index) {
    if (state.venueFormItem.homeServices[index].id == null) {
      state.venueFormItem.homeServices.splice(index, 1)
    } else {
      state.venueFormItem.homeServices[index].Destroy = true
    }
  }
}
