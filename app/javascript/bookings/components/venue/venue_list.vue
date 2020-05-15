<template>
  <div class="d-flex justify-content-center mt-4">
    <div class="d-flex flex-wrap px-2">
      <VenueListItem v-for="venueItem in venueItems"
                     :key="venueItem.id"
                     :venueItem="venueItem"
                     :active="venueItem.id == currentVenueId" />

      <BookingForm />

      <BookingCalendar />
    </div>
  </div>
</template>

<script>
  import VenueListItem from 'bookings/components/venue/venue_list_item'
  import BookingForm from 'bookings/components/booking/booking_form'
  import BookingCalendar from 'bookings/components/booking/booking_calendar'
  import { mapGetters, mapActions } from 'vuex'

  export default {
    name: 'VenueList',
    components: {
      VenueListItem,
      BookingForm,
      BookingCalendar
    },
    computed: {
      ...mapGetters([
        'venueItems',
        'currentVenueId'
      ]),
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
