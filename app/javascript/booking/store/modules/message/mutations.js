export default {
  UPDATE_MESSAGE_ITEMS(state, payload) {
    state.messageItems = payload
  },
  ADD_MESSAGE_ITEM(state, payload) {
    state.messageItems.unshift(payload)
  }
}
