import Vue from 'vue/dist/vue.esm'
import Vuex from 'vuex'
import venue from './modules/venue'

Vue.use(Vuex)

export default new Vuex.Store({
  modules: {
    venue
  }
})
