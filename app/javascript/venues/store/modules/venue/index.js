import mutations from './mutations'
import actions from './actions'
import getters from './getters'

const state = {
  venueItems: null,
  venueItem: null,
  venueFormItem: null,
  venueOwnerFormItems: null,
  venuePagy: null,
  sidebar: false
}

export default {
  state,
  mutations,
  actions,
  getters
}
