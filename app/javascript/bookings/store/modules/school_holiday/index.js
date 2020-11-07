import mutations from './mutations'
import actions from './actions'
import getters from './getters'

const state = {
  currentSchoolHolidayZones: null,
  schoolHolidayItems: []
}

const schoolHolidayModule = {
  state,
  mutations,
  actions,
  getters
}

export default schoolHolidayModule
