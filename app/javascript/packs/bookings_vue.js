import TurbolinksAdapter from 'vue-turbolinks'
import Vue from 'vue/dist/vue.esm'
import store from 'bookings/store'
import App from 'bookings/app'
import VCalendar from 'v-calendar'

Vue.use(TurbolinksAdapter)
Vue.use(VCalendar, {
  screens: {
    tablet: '576px',
    laptop: '992px',
    desktop: '1200px',
  },
})

document.addEventListener('turbolinks:load', () => {
  const element = document.getElementById('bookings-vue')
  if (element) new Vue({
    store,
    plugins: [
      { src: '~/plugins/v-calendar', mode: 'client' },
    ],
    render: h => h(App)
  }).$mount(element)
})
