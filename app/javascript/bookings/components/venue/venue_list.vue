<template>
  <div class="d-flex overflow-auto mt-2 px-4">
    <VenueListItem v-for="venueItem in venueItems"
                   :key="venueItem.id"
                   :venueItem="venueItem"
                   :currentVenue="currentVenue" />
  </div>
</template>

<script>
  import VenueListItem from 'bookings/components/venue/venue_list_item'

  export default {
    name: 'VenueList',
    props: ['venueItems', 'currentVenue'],
    components: {
      VenueListItem
    }
  }
</script>
