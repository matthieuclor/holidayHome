<template>
  <div v-if="venueItems && currentVenue">
    <ul class="list-group list-group-horizontal-md">
      <li class="list-group-item list-group-item-action flex-fill">Cras justo odio</li>
      <li class="list-group-item list-group-item-action flex-fill">Dapibus ac facilisis in</li>
    </ul>

    <VenueList :venueItems="venueItems" :currentVenue="currentVenue" />

    <BookingList :currentVenue="currentVenue" />

    <BookingForm :currentVenue="currentVenue" />

    <BookingCalendar />

    <div id="v-toast-container">
      <FlashMessage v-for="(flash, index) in flashes" :key="index" :flash="flash" />
    </div>
  </div>
</template>

<script>
  import BookingList from 'bookings/components/booking/booking_list'
  import VenueList from 'bookings/components/venue/venue_list'
  import BookingForm from 'bookings/components/booking/booking_form'
  import BookingCalendar from 'bookings/components/booking/booking_calendar'
  import FlashMessage from 'shared/components/flash/flash_message'
  import { mapGetters, mapActions } from 'vuex'

  export default {
    name: 'App',
    computed: {
      ...mapGetters([
        'venueItems',
        'currentVenue',
        'flashes'
      ])
    },
    components: {
      BookingList,
      VenueList,
      BookingForm,
      BookingCalendar,
      FlashMessage
    },
    methods: {
      ...mapActions([
        'getVenueItems'
      ])
    },
    created() {
      this.getVenueItems()
    }
  }
</script>
