import mutations from './mutations'
import actions from './actions'
import getters from './getters'

const state = {
  messageItems: [],
  messagePagy: null
}

const messageModule = {
  state,
  mutations,
  actions,
  getters
}

export default messageModule
