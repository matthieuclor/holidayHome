<template>
  <div class="col-12 mt-3">
    <div class="card">
      <div class="card-body">
        <div class="d-flex flex-column flex-md-row justify-content-center align-items-center">
          <div class="col-sm-12 col-md-6 col-lg-4 mb-3 mb-md-0">
            <SchoolHolidayZoneForm />
          </div>
          <div class="col-sm-12 col-md-6 col-lg-5">
            <BookingForm />
          </div>
        </div>
      </div>
    </div>

    <BookingModalForm v-show="bookingModalForm" />
  </div>
</template>

<script>
  import BookingForm from './booking_form'
  import SchoolHolidayZoneForm from 'bookings/components/school_holiday/school_holiday_zone_form'
  import BookingModalForm from './booking_modal_form'
  import { mapGetters } from 'vuex'

  export default {
    name: 'BookingFormContainer',
    computed: {
      ...mapGetters(['bookingModalForm'])
    },
    components: {
      SchoolHolidayZoneForm,
      BookingForm,
      BookingModalForm
    },
  }
</script>
