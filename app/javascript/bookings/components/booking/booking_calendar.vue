<template>
  <div v-if="bookingItems" class="d-flex justify-content-center my-3">
    <div class="w-100 px-3">
      <v-calendar @update:fromPage="updatePage"
                  @dayclick="linkToBooking"
                  :columns="layout.columns"
                  :rows="layout.rows"
                  :is-expanded="true"
                  :attributes="attributes"
                  ref="calendar" />
    </div>
  </div>
</template>

<script>
  import { mapGetters, mapActions } from 'vuex'

  export default {
    name: 'BookingCalendar',
    computed: {
      ...mapGetters([
        'bookingItems',
        'currentVenue',
        'calendar'
      ]),
      layout() {
        return this.$screens(
          {
            default: { columns: 1, rows: 12 },
            sm: { columns: 1, rows: 12 },
            md: { columns: 3, rows: 4 },
            lg: { columns: 4, rows: 3 },
            xl: { columns: 4, rows: 3 }
          }
        )
      },
      attributes() {
        return this.bookingItems.map(
          item => {
            return {
              key: item.id,
              highlight: {
                color: `${item.status == 'accepted' ? 'green' : 'orange'}`,
                fillMode: 'light'
              },
              popover: {
                label: item.label
              },
              dates: [{ start: new Date(item.from), end: new Date(item.to) }]
            }
          }
        )
      },
    },
    methods: {
      ...mapActions([
        'getBookingItems',
        'updateCalendar'
      ]),
      updatePage(event) {
        const calendar = this.$refs.calendar
        if (!calendar) return

        this.updateCalendar({
          month: event.month,
          year: event.year,
          monthCount: calendar.count
        })

        this.getBookingItems(this.calendar)
      },
      linkToBooking(day) {
        if (day.attributes) {
          location.replace(`/user_account/bookings/${day.attributes[0].key}`)
        }
      }
    },
    watch: {
      currentVenue: {
        handler() {
          if (!this.calendar) {
            const currentDate = new Date()

            this.updateCalendar({
              month: currentDate.getMonth() + 1,
              year: currentDate.getFullYear(),
              monthCount: 12
            })
          }

          this.getBookingItems(this.calendar)
        },
        immediate: true
      }
    }
  }
</script>

<style scoped>
  .vc-container {
    border: 0;
    border-radius: .3125rem;
    box-shadow: 0 0 0.625rem rgba(0, 0, 0, 0.15);
  }
</style>
