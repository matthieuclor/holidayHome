<template>
  <div class="d-flex container-with-sidebar"
       :class="{ active: sidebar }">

    <VenueList />

    <VenueContainer />

    <div id="v-toast-container">
      <FlashMessage v-for="(flash, index) in flashes"
                    :key="index"
                    :flash="flash" />
    </div>
  </div>
</template>

<script>
  import VenueList from 'venues/components/venue/venue_list'
  import VenueContainer from 'venues/components/venue/venue_container'
  import FlashMessage from 'shared/components/flash/flash_message'
  import { mapGetters } from 'vuex'

  export default {
    name: 'App',
    computed: {
      ...mapGetters([
        'flashes',
        'sidebar'
      ])
    },
    components: {
      VenueList,
      VenueContainer,
      FlashMessage
    }
  }
</script>
