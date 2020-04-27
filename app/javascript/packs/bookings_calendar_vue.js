import TurbolinksAdapter from 'vue-turbolinks'
import Vue from 'vue/dist/vue.esm'
import VCalendar from 'v-calendar'

Vue.use(TurbolinksAdapter)
Vue.use(VCalendar)

document.addEventListener('turbolinks:load', () => {
  new Vue({
    el: '#bookings_calendar',
    data: () => {
      return {
        booking: {
          dateRange: null
        },
        attributes: [
          {
            key: 'today',
            highlight: true,
            dates: new Date()
          }
        ]
      }
    },
    watch: {
      'booking.dateRange': function(val) {
        console.log("dateRange", val)
      }
    }
  })
})

