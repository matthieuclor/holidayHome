<template>
  <div class="d-flex justify-content-center mt-3">
    <div class="col-md-12 col-lg-10">
      <div v-if="bookingFormItems" class="card">
        <div class="card-body">
          <div class="d-flex justify-content-center align-items-center ">
            <form @submit.prevent="submitBookingForm" class="form-inline mr-2">
              <div class="form-group">
                <label class="mr-2">
                  Créer une nouvelle réservation pour&nbsp;
                  <span class="font-weight-bold">{{ currentVenue.name }}</span>
                </label>
                <v-date-picker @update:fromPage="updatePage"
                               @input="submitBookingForm"
                               mode="range"
                               v-model="dateRange"
                               :disabled-dates="disabledDates"
                               ref="formCalendar" />
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>

    <BookingModalForm v-show="bookingModalForm" :currentVenue="currentVenue" />
  </div>
</template>

<script>
  import BookingModalForm from './booking_modal_form'
  import { mapGetters, mapActions } from 'vuex'

  export default {
    name: 'BookingForm',
    props: ['currentVenue'],
    data: () => ({ dateRange: null }),
    computed: {
      ...mapGetters([
        'formCalendar',
        'bookingFormItems',
        'bookingModalForm',
        'bookingDateRange',
        'currentUser'
      ]),
      disabledDates() {
        return this.bookingFormItems.map(
          item => ({ start: new Date(item.from), end: new Date(item.to) })
        )
      }
    },
    components: {
      BookingModalForm
    },
    methods: {
      ...mapActions([
        'getBookingFormItems',
        'updateFormCalendar',
        'updateBookingDateRange',
        'updateBookingModalForm'
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
        if (this.dateRange) {
          this.updateBookingDateRange(this.dateRange)
          this.updateBookingModalForm(true)
        }
      }
    },
    watch: {
      currentVenue: {
        handler() {
          const currentDate = new Date()

          this.updateFormCalendar({
            month: currentDate.getMonth() + 1,
            year: currentDate.getFullYear(),
            monthCount: 1
          })

          this.getBookingFormItems(this.formCalendar)
        },
        immediate: true
      },
      bookingDateRange() {
        this.dateRange = this.bookingDateRange
      }
    }
  }
</script>
