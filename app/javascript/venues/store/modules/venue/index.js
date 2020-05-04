import mutations from './mutations'
import actions from './actions'
import getters from './getters'

const state = {
  venueItems: [],
  venueItem: null,
  newVenueItem: null,
  formIsEditing: false
}

const venueModule = {
  state,
  mutations,
  actions,
  getters
}

export default venueModule
