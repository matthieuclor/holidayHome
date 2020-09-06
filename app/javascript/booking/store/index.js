import Vue from 'vue/dist/vue.esm'
import Vuex from 'vuex'
import booking from './modules/booking'
import booking_approval from './modules/booking_approval'
import messages from './modules/message'
import flash from 'shared/store/modules/flash'

Vue.use(Vuex)

export default new Vuex.Store({
  modules: {
    booking,
    booking_approval,
    messages,
    flash
  }
})
