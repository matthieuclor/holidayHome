import TurbolinksAdapter from 'vue-turbolinks'
import Vue from 'vue/dist/vue.esm'
import store from 'messages/store'
import App from 'messages/app'
import consumer from "../channels/consumer"

Vue.use(TurbolinksAdapter)

document.addEventListener('turbolinks:load', () => {
  const element = document.getElementById('messages-vue')

  if (element) {
    const bookingId = document.getElementById('messages-container')
      .getAttribute('data-booking-id')

    new Vue({ store, render: h => h(App) }).$mount(element)

    consumer.subscriptions.create({ channel: "BookingChannel", booking_id: bookingId }, {
      received(data) {
        store.commit('ADD_MESSAGE_ITEM', JSON.parse(data['message']))
      }
    })
  }
})
