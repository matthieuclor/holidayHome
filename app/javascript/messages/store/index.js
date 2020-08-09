import Vue from 'vue/dist/vue.esm'
import Vuex from 'vuex'
import message from './modules/message'

Vue.use(Vuex)

export default new Vuex.Store({
  modules: {
    message
  }
})
