<template>
  <div v-if="venueItems && currentVenue">
    <VenueList :venueItems="venueItems" :currentVenue="currentVenue" />

    <BookingList :currentVenue="currentVenue" />

    <BookingForm :currentVenue="currentVenue" />

    <BookingCalendar />

    <PlanInfoCard v-if="planError" :planError="planError" />

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
  import PlanInfoCard from 'shared/components/plan_error/plan_info_card'
  import { mapGetters, mapActions } from 'vuex'

  export default {
    name: 'App',
    computed: {
      ...mapGetters([
        'venueItems',
        'currentVenue',
        'flashes',
        'planError'
      ])
    },
    components: {
      BookingList,
      VenueList,
      BookingForm,
      BookingCalendar,
      PlanInfoCard,
      FlashMessage
    },
    methods: {
      ...mapActions(['getVenueItems'])
    },
    created() {
      this.getVenueItems()
    }
  }
</script>
