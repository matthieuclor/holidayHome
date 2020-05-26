<template>
  <div v-if="bookingFormItems" class="d-flex justify-content-center mt-3 mb-4">
    <form @submit.prevent="submitBookingForm" class="form-inline">
      <div class="form-group">
        <label class="mr-2">
          Créer une nouvelle réservation pour&nbsp;
          <span class="font-weight-bold">{{ currentVenue.name }}</span>
        </label>
        <v-date-picker @update:from-page="updatePage"
                       mode="range"
                       v-model="dateRange"
                       :disabled-dates="disabledDates"
                       ref="formCalendar" />
      </div>

      <button type="submit" class="btn btn-primary ml-2">Envoyer</button>
    </form>
  </div>
</template>

<script>
  import { mapGetters, mapActions } from 'vuex'

  export default {
    name: 'BookingForm',
    props: ['currentVenue'],
    data() {
      return { dateRange: null }
    },
    computed: {
      ...mapGetters([
        'calendar',
        'formCalendar',
        'bookingFormItems'
      ]),
      disabledDates() {
        return this.bookingFormItems.map(
          item => {
            return { start: new Date(item.from), end: new Date(item.to) }
          }
        )
      }
    },
    methods: {
      ...mapActions([
        'createBooking',
        'getBookingFormItems',
        'updateFormCalendar'
      ]),
      updatePage(event) {
        const formCalendar = this.$refs.formCalendar
        if (!formCalendar) return

        this.updateFormCalendar({
          month: event.month,
          year: event.year,
          monthCount: formCalendar.count
        })

        this.getBookingFormItems(this.formCalendar)
      },
      submitBookingForm() {
        this.createBooking({ ...this.dateRange, ...this.calendar})
        .then(() => this.dateRange = null)
      }
    },
    watch: {
      currentVenue: {
        handler() {
          if (!this.formCalendar) {
            const currentDate = new Date()

            this.updateFormCalendar({
              month: currentDate.getMonth() + 1,
              year: currentDate.getFullYear(),
              monthCount: 1
            })
          }

          this.getBookingFormItems(this.formCalendar)
        },
        immediate: true
      }
    }
  }
</script>
