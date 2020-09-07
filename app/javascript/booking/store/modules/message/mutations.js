export default {
  UPDATE_MESSAGE_ITEMS(state, payload) {
    state.messageItems = [...state.messageItems, ...payload]
  },
  UPDATE_MESSAGE_PAGY(state, payload) {
    state.messagePagy = payload
  },
  ADD_MESSAGE_ITEM(state, payload) {
    state.messageItems.unshift(payload)
  }
}
