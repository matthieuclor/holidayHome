import Vue from 'vue/dist/vue.esm'
import Vuex from 'vuex'
import venue from './modules/venue'
import flash from 'shared/store/modules/flash'
import planError from 'shared/store/modules/plan_error'

Vue.use(Vuex)

export default new Vuex.Store({
  modules: {
    venue,
    flash,
    planError
  }
})
