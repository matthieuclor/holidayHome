<template>
  <div class="d-flex justify-content-center mt-3 mb-4">
    <div class="col-md-12 col-lg-10">
      <div class="card border-0 shadow">
        <div class="card-body">
          <div class="d-flex justify-content-between align-items-center mb-3">
            <h5 class="card-title mb-0">
              Demande de réservation en attente de votre approbation pour {{currentVenue.name}}
            </h5>

            <a :href="`/user_account/bookings?q%5Buser_id_eq%5D=${currentUser.id}&q%5Bstatus_eq%5D=0#/`">
              <button class="btn btn-primary">
                <i class="fas fa-tasks mr-2"></i>
                Gérer mes réservations
              </button>
            </a>
          </div>

          <div class="list-group">
            <BookingListItem v-for="bookingPendingItem in bookingPendingItems"
                            :key="bookingPendingItem.id"
                            :bookingPendingItem="bookingPendingItem" />
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  import BookingListItem from './booking_list_item'
  import { mapGetters, mapActions } from 'vuex'

  export default {
    name: 'BookingList',
    props: ['currentVenue'],
    computed: {
      ...mapGetters([
        'bookingPendingItems',
        'currentUser'
      ])
    },
    components: {
      BookingListItem
    },
     methods: {
      ...mapActions(['getBookingPendingItems'])
     },
     watch: {
      currentVenue: {
        handler() {
          this.getBookingPendingItems()
        },
        immediate: true
      }
    }
  }
</script>
