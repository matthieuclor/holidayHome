import axios from 'axios'
import qs from 'qs';

export default {
  getVenueItems({ commit }) {
    axios.get('dashboards.json').then((response) => {
      commit('UPDATE_VENUE_ITEMS', response.data.venues)
      commit('UPDATE_CURRENT_VENUE', response.data.currentVenue)
    })
  },
  setCurrentVenue({ commit }, id) {
    const csrfToken = document.querySelector('[name=csrf-token]').content

    axios(
      {
        method: 'patch',
        url: 'current_venues.json',
        data: qs.stringify({ current_venue: { id: id } }),
        headers: { 'X-CSRF-TOKEN': csrfToken }
      }
    ).then(response => {
      commit('UPDATE_CURRENT_VENUE', response.data.currentVenue)
      commit('UPDATE_FLASHES', response.data.flashes)
    }).catch(error => {
      commit('UPDATE_FLASHES', error.response.data.flashes)
    })
  }
}
