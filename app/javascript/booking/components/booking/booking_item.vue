<template>
  <div v-if="bookingItem">
    <div class="d-flex justify-content-center align-items-center mt-4">
      <h1>
        Demande de réservation pour {{ bookingItem.venueName }}
      </h1>
    </div>

    <div class="d-flex justify-content-center">
      <div class="col-md-8 col-lg-6">
        <div class="card">
          <div class="card-body">
            <div class="row">
              <div class="col-6">
                <VenuePhoto :photoUrl="bookingItem.venuePhotoUrl"
                            :format="[200, 100]"/>
              </div>
              <div class="col-6">
                <p class="mb-2">
                  <i class="fas fa-user"></i>
                  <a :href="`/user_account/users/${bookingItem.userId}`"
                     data-remote="true">

                    <span class="text-muted ml-2">
                      {{ bookingItem.userName }}
                    </span>
                  </a>
                </p>

                <p class="mb-2">
                  <i class="fas fa-calendar-alt"></i>
                  <span class="text-muted ml-2">
                    {{ bookingItem.dateRange }}
                  </span>
                </p>

                <div class="mb-2 d-flex align-items-center">
                  <i class="fas fa-info-circle mr-2"></i>
                  <BookingStatusBadge :statusFr="bookingItem.statusFr"
                                      :status="bookingItem.status"/>
                </div>

                <div v-if="!(bookingItem.status == 'canceled')">
                  <i class="fas fa-hourglass-half"></i>
                  <span class="text-muted ml-2">
                    Deadline
                  </span>
                  <div class="mt-2">
                    <BookingProgressBar :percentage="bookingItem.progressPercentage"
                                        :title="bookingItem.progressTitle"/>
                  </div>
                </div>
              </div>
            </div>
            <div class="row mt-2 d-flex align-items-center">
              <div class="col-6">
                <BookingApprovalCard :bookingApprovals="bookingApprovalItems"
                                     :bookingStatus="bookingItem.status"/>
              </div>
              <div class="col-6">
                <BookingAction :booking="bookingItem"
                               :bookingApprovals="bookingApprovalItems" />
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  import VenuePhoto from '../venue/venue_photo'
  import BookingStatusBadge from './booking_status_badge'
  import BookingProgressBar from './booking_progress_bar'
  import BookingAction from './booking_action'
  import BookingApprovalCard from '../booking_approval/booking_approval_card'
  import { mapGetters, mapActions } from 'vuex'

  export default {
    name: 'BookingItem',
    computed: {
      ...mapGetters([
        'bookingItem',
        'bookingApprovalItems'
      ]),
      bookingId() {
        return document.getElementById('booking-container').getAttribute('data-booking-id')
      }
    },
    methods: {
      ...mapActions(['getBookingItem'])
    },
    components: {
      VenuePhoto,
      BookingStatusBadge,
      BookingProgressBar,
      BookingAction,
      BookingApprovalCard
    },
    created() {
      this.getBookingItem(this.bookingId)
    }
  }
</script>
