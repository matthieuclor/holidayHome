<template>
  <div v-if="venueItems && currentVenue">
    <VenueList :venueItems="venueItems" :currentVenue="currentVenue" />

    <BookingForm :currentVenue="currentVenue" />

    <BookingCalendar />

    <div id="v-toast-container">
      <FlashMessage v-for="(flash, index) in flashes" :key="index" :flash="flash" />
    </div>
  </div>
</template>

<script>
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
