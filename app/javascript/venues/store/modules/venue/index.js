import mutations from './mutations'
import actions from './actions'
import getters from './getters'

const state = {
  venueItems: [],
  venueItem: null
}

const venueModule = {
  state,
  mutations,
  actions,
  getters
}

export default venueModule