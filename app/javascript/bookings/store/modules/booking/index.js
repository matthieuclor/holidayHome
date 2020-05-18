import mutations from './mutations'
import actions from './actions'
import getters from './getters'

const state = {
  bookingItems: null
}

const bookingModule = {
  state,
  mutations,
  actions,
  getters
}

export default bookingModule
