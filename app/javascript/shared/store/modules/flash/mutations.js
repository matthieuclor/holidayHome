export default {
  UPDATE_FLASHES(state, payload) {
    state.flashes = state.flashes.concat(payload)
  },
  REMOVE_LAST_FLASH(state) {
    state.flashes.pop()
  }
}
