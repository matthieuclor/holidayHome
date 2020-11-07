<template>
  <div class="d-flex justify-content-center mt-3">
    <div class="col-12">
      <ul v-for="(chunkedItems, index) in chunkedVenueItems"
          :key="index"
          class="list-group list-group-horizontal-md">

        <VenueListItem v-for="venueItem in chunkedItems"
                       :key="venueItem.id"
                       :venueItem="venueItem"
                       :currentVenue="currentVenue" />

      </ul>
    </div>
  </div>
</template>

<script>
  import VenueListItem from 'bookings/components/venue/venue_list_item'
  import { mapGetters } from 'vuex'

  export default {
    name: 'VenueList',
    components: {
      VenueListItem
    },
    computed: {
      ...mapGetters([
        'currentVenue',
        'chunkedVenueItems'
      ])
    },
  }
</script>
