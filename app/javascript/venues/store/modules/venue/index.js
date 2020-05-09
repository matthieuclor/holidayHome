import mutations from './mutations'
import actions from './actions'
import getters from './getters'

const state = {
  venueItems: [],
  venueItem: null,
  venueFormItem: null,
  venueOwnerFormItems: [],
  venuePagy: null,
  flashes: [],
  sidebar: false
}

const venueModule = {
  state,
  mutations,
  actions,
  getters
}

export default venueModule
