<template>
  <div class="d-flex justify-content-center mt-3 mb-4">
    <form class="form-inline">
      <div class="form-group">
        <label class="mr-2">
          Faire une nouvelle demande de séjour pour&nbsp;
          <span class="font-weight-bold">{{ currentVenue.name }}</span>
        </label>
        <v-date-picker mode="range" v-model="booking.dateRange" />
      </div>

      <button type="submit" class="btn btn-primary ml-2">Envoyer</button>
    </form>
  </div>
</template>

<script>
  export default {
    name: 'BookingForm',
    props: ['currentVenue'],
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
