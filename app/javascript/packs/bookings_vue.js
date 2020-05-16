import TurbolinksAdapter from 'vue-turbolinks'
import Vue from 'vue/dist/vue.esm'
import VCalendar from 'v-calendar'
import store from 'bookings/store'
import App from 'bookings/app'

Vue.use(TurbolinksAdapter)
Vue.use(VCalendar)

document.addEventListener('turbolinks:load', () => {
  const element = document.getElementById('bookings-vue')
  if (element) new Vue({
    store,
    render: h => h(App)
  }).$mount(element)
})
