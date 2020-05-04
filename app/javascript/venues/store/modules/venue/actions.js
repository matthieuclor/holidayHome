import axios from 'axios'

export default {
  getVenueItems({ commit }) {
    axios.get('venues.json').then((response) => {
      commit('UPDATE_VENUE_ITEMS', response.data)
    })
  },
  getVenueItem({ commit }, id) {
    axios.get(`venues/${id}.json`).then((response) => {
      commit('UPDATE_VENUE_ITEM', response.data)
    })
  },
  getNewVenueItem({ commit }) {
    axios.get(`venues/new.json`).then((response) => {
      commit('UPDATE_NEW_VENUE_ITEM', response.data)
    })
  },
  addBedroom({ commit }) {
    commit(
      'ADD_BEDROOM',
      {
        id: null,
        name: null,
        Destroy: false,
        errors: {},
        beddings: [
          {
            id: null,
            bedCount: 0,
            bedType: 'single',
            tBedType: 'simple',
            Destroy: false
          },
          {
            id: null,
            bedCount: 0,
            bedType: 'double',
            tBedType: 'double',
            Destroy: false
          },
          {
            id: null,
            bedCount: 0,
            bedType: 'baby',
            tBedType: 'bébé',
            Destroy: false
          }
        ]
      }
    )
  },
  removeBedroom({ commit }, index) {
    commit('REMOVE_BEDROOM', index)
  },
  addBathroom({ commit }) {
    commit(
      'ADD_BATHROOM',
      {
        id: null,
        name: null,
        Destroy: false,
        errors: {}
      }
    )
  },
  removeBathroom({ commit }, index) {
    commit('REMOVE_BATHROOM', index)
  }
}
