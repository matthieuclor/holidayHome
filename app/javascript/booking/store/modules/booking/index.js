import mutations from './mutations'
import actions from './actions'
import getters from './getters'

const state = {
  bookingItem: null,
  bookingCurrentUsers: []
}

const bookingModule = {
  state,
  mutations,
  actions,
  getters
}

export default bookingModule
