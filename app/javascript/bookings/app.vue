<template>
  <div>
    <VenueList />

    <div id="v-toast-container">
      <FlashMessage v-for="(flash, index) in flashes"
                    :key="index"
                    :flash="flash" />
    </div>
  </div>
</template>

<script>
  import VenueList from 'bookings/components/venue/venue_list'
  import FlashMessage from 'shared/components/flash/flash_message'
  import { mapGetters } from 'vuex'

  export default {
    name: 'App',
    computed: {
      ...mapGetters(['flashes'])
    },
    components: {
      VenueList,
      FlashMessage
    }
  }
</script>
