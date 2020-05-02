import axios from 'axios'

export default {
  getVenueItems({ commit }) {
    axios.get('venues.json').then((response) => {
      commit('UPDATE_VENUE_ITEMS', response.data)
    })
  },
  getVenueItem({ commit }, id) {
    axios.get(`${id}.json`).then((response) => {
      commit('UPDATE_VENUE_ITEM', response.data)
    })
  }
}
