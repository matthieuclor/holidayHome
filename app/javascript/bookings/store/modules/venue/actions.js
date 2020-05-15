import axios from 'axios'

export default {
  getVenueItems({ commit }) {
    axios.get('dashboards.json').then((response) => {
      commit('UPDATE_VENUE_ITEMS', response.data.venues)
      commit('UPDATE_CURRENT_VENUE_ID', response.data.currentVenueId)
    })
  }
}
