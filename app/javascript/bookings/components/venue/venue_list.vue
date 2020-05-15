<template>
  <div>
    <div class="d-flex overflow-auto mt-2 px-4">
      <VenueListItem v-for="venueItem in venueItems"
                      :key="venueItem.id"
                      :venueItem="venueItem"
                      :currentVenueId="currentVenueId" />
    </div>

    <BookingForm />

    <BookingCalendar />
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
