<template>
  <div v-if="bookingItems" class="d-flex justify-content-center mb-4">
    <div class="col-12">
      <v-calendar :columns="4"
                  :rows="3"
                  :is-expanded="true"
                  :attributes="attributes" />
    </div>
  </div>
</template>

<script>
  import { mapGetters, mapActions } from 'vuex'

  export default {
    name: 'BookingCalendar',
    computed: {
      ...mapGetters(['bookingItems', 'currentVenue']),
      attributes() {
        return this.bookingItems.map(
          item => {
            return {
              key: item.id,
              highlight: true,
              dates: [{ start: new Date(item.from), end: new Date(item.to) }]
            }
          }
        )
      }
    },
    methods: {
      ...mapActions(['getBookingItems'])
    },
    watch: {
      currentVenue: {
        handler() { this.getBookingItems() },
        immediate: true
      }
    }
  }
</script>
