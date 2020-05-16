import TurbolinksAdapter from 'vue-turbolinks'
import Vue from 'vue/dist/vue.esm'
import store from 'venues/store'
import router from 'venues/router'
import App from 'venues/app'

Vue.use(TurbolinksAdapter)

document.addEventListener('turbolinks:load', () => {
  const element = document.getElementById('venues-vue')
  if (element) new Vue({
    store,
    router,
    render: h => h(App)
  }).$mount(element)
})
