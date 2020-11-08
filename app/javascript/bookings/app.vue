<template>
  <div>
    <VenueList />

    <BookingList />

    <BookingForm />

    <BookingCalendar />

    <PlanInfoCard />

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
      ...mapGetters(['flashes'])
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
