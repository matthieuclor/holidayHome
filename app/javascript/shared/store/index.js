import Vue from 'vue/dist/vue.esm'
import Vuex from 'vuex'
import flash from './modules/flash'

Vue.use(Vuex)

export default new Vuex.Store({
  modules: {
    flash
  }
})
