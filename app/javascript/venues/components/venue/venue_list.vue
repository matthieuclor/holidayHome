<template>
  <div>
    <div class="d-flex justify-content-between align-items-center">
      <h1>Mes lieux</h1>
    </div>

    <VenueListItem v-for="venueItem in venueItems"
                   :key="venueItem.id"
                   :venueItem="venueItem" />
  </div>
</template>

<script>
  import VenueListItem from 'venues/components/venue/venue_list_item'
  import { mapGetters } from 'vuex'

  export default {
    name: 'VenueList',
    components: {
      VenueListItem
    },
    computed: {
      ...mapGetters([
        'venueItems'
      ]),
    },
    created() {
      this.$store.dispatch('getVenueItems')
    }
  }
</script>
