import mutations from './mutations'
import actions from './actions'
import getters from './getters'

const state = {
  messageItems: []
}

const messageModule = {
  state,
  mutations,
  actions,
  getters
}

export default messageModule
