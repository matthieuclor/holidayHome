<template>
  <div class="d-flex justify-content-center my-2">
    <v-date-picker mode="range" v-model="booking.dateRange" />
  </div>
</template>

<script>
  export default {
    name: 'BookingForm',
    data() {
      return {
        booking: {
          dateRange: null
        }
      }
    },
    watch: {
      'booking.dateRange': function(val) {
        console.log("dateRange", val)
      }
    }
  }
</script>
