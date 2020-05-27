import Vue from 'vue/dist/vue.esm'
import Vuex from 'vuex'
import venue from './modules/venue'
import booking from './modules/booking'
import calendar from './modules/calendar'
import user from './modules/user'
import flash from 'shared/store/modules/flash'

Vue.use(Vuex)

export default new Vuex.Store({
  modules: {
    venue,
    calendar,
    booking,
    user,
    flash
  }
})
