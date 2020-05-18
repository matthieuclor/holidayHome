import Vue from 'vue/dist/vue.esm'
import Vuex from 'vuex'
import venue from './modules/venue'
import booking from './modules/booking'
import flash from 'shared/store/modules/flash'

Vue.use(Vuex)

export default new Vuex.Store({
  modules: {
    venue,
    booking,
    flash
  }
})
