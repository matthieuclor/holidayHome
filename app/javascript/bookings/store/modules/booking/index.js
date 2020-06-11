import mutations from './mutations'
import actions from './actions'
import getters from './getters'

const state = {
  bookingPendingItems: null,
  bookingItems: null,
  bookingFormItems: null,
  bookingDateRange: null,
  bookingModalForm: false
}

const bookingModule = {
  state,
  mutations,
  actions,
  getters
}

export default bookingModule
