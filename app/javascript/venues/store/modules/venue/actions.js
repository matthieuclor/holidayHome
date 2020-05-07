import axios from 'axios'

export default {
  getVenueItems({ commit }, page = 1) {
    axios.get(`venues.json?page=${page}`).then((response) => {
      commit('UPDATE_VENUE_ITEMS', response.data.venues)
      commit('UPDATE_VENUE_PAGY', response.data.pagy)
    })
  },
  getVenueItem({ commit }, id) {
    axios.get(`venues/${id}.json`).then((response) => {
      commit('UPDATE_VENUE_ITEM', response.data)
    })
  },
  getFormData({ commit }, id) {
    const url = 'venues/' +  (id ? `${id}/edit.json` : 'new.json')

    axios.get(url).then((response) => {
      commit('UPDATE_FORM_VENUE_ITEM', response.data.venue)
      commit('UPDATE_FORM_VENUE_OWNER_ITEMS', response.data.owners)
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
    commit('ADD_BATHROOM', { id: null, name: null, Destroy: false, errors: {} })
  },
  removeBathroom({ commit }, index) {
    commit('REMOVE_BATHROOM', index)
  },
  addKey({ commit }) {
    commit('ADD_KEY', { id: null, name: null, Destroy: null, errors: {} })
  },
  removeKey({ commit }, index) {
    commit('REMOVE_KEY', index)
  },
  addNetwork({ commit }) {
    commit(
      'ADD_NETWORK',
      { id: null, name: null, password: null, Destroy: null, errors: {} }
    )
  },
  removeNetwork({ commit }, index) {
    commit('REMOVE_NETWORK', index)
  },
  addDigitalCode({ commit }) {
    commit(
      'ADD_DIGITAL_CODE',
      { id: null, name: null, password: null, Destroy: null, errors: {} }
    )
  },
  removeDigitalCode({ commit }, index) {
    commit('REMOVE_DIGITAL_CODE', index)
  },
  addHomeService({ commit }) {
    commit(
      'ADD_HOME_SERVICE',
      {
        id: null,
        name: null,
        personInCharge: null,
        address: null,
        phone: null,
        email: null,
        Destroy: null,
        errors: {}
      }
    )
  },
  removeHomeService({ commit }, index) {
    commit('REMOVE_HOME_SERVICE', index)
  },
  sendVenueForm({ commit, dispatch }, formData) {
    commit('SET_VENUE_FORM_SENDING', true)

    const csrfToken = document.querySelector('[name=csrf-token]').content
    const venueId = formData.get('venue[id]')
    const method = venueId ? 'patch' : 'post'
    const url = `/user_account/venues${venueId ? `/${venueId}` : '' }.json`

    return new Promise((resolve, reject) => {
      axios(
        {
          method: method,
          url: url,
          data: formData,
          headers: {
            'X-CSRF-TOKEN': csrfToken,
            'Content-Type': 'multipart/form-data'
          }
        }
      ).then(response => {
          dispatch('getVenueItems')
          resolve(response)
      }).catch(error => {
          commit('UPDATE_FORM_VENUE_ITEM', error.response.data.venue)
          reject(error)
      })

      commit('SET_VENUE_FORM_SENDING', false)
    })
  }
}
