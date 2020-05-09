import TurbolinksAdapter from 'vue-turbolinks'
import Vue from 'vue/dist/vue.esm'
import store from 'venues/store'
import router from 'venues/router'
import VenueList from 'venues/components/venue/venue_list'
import VenueContainer from 'venues/components/venue/venue_container'
import FlashMessage from 'venues/components/toast/flash_message'
import { mapGetters } from 'vuex'

Vue.use(TurbolinksAdapter)

document.addEventListener('turbolinks:load', () => {
  new Vue({
    store,
    router,
    el: '#app',
    computed: {
      ...mapGetters(['flashes', 'sidebar'])
    },
    components: {
      'venue-list': VenueList,
      'venue-container': VenueContainer,
      'flash-message': FlashMessage
    }
  })
})
