<template>
  <div class="d-flex justify-content-center mt-3 mb-4">
    <form @submit.prevent="submitBookingForm" class="form-inline">
      <div class="form-group">
        <label class="mr-2">
          Créer une nouvelle réservation pour&nbsp;
          <span class="font-weight-bold">{{ currentVenue.name }}</span>
        </label>
        <v-date-picker mode="range" v-model="dateRange" />
      </div>

      <button type="submit" class="btn btn-primary ml-2">Envoyer</button>
    </form>
  </div>
</template>

<script>
  import { mapActions } from 'vuex'

  export default {
    name: 'BookingForm',
    props: ['currentVenue'],
    data() {
      return { dateRange: null }
    },
    methods: {
      ...mapActions(['createBooking']),
      submitBookingForm() {
        this.createBooking(this.dateRange)
        .then(() => this.dateRange = null)
      }
    }
  }
</script>
