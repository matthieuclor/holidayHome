<template>
  <div v-if="booking.status == 'pending'">
    <button v-if="booking.userId == currentUserId"
            @click="cancelBooking"
            class="btn btn-sm btn-block btn-danger">

      <i class="fas fa-trash mr-2"></i>
      Annuler la réservation
    </button>

    <div v-else-if="currentApproval">
      <div v-if="currentApproval.status == 'pending'">
        <button @click="showApprovalForm('accepted')"
                class="btn btn-sm btn-block btn-success mb-2">

          <i class="fas fa-thumbs-up mr-2"></i>
          Approuver la réservation
        </button>

        <button @click="showApprovalForm('refused')"
                class="btn btn-sm btn-block btn-danger">

          <i class="fas fa-thumbs-down mr-2"></i>
          Rejeter la réservation
        </button>
      </div>
      <div v-else>
        Vous avez
        <span class="text-lowercase font-weight-bolder"
              :class="statusTextClass">
          {{ currentApproval.statusTitle }}
        </span>
        la demande.
        <br>
        Vous pouvez encore changer d'avis :
        <br>
        <a v-if="currentApproval.status == 'refused'"
           @click.prevent="showApprovalForm('accepted')"
           href="#"
           class="text-success">

          Approuver la réservation
        </a>
        <a v-else
           @click.prevent="showApprovalForm('refused')"
           href="#"
           class="text-danger">

          Rejeter la réservation
        </a>
      </div>

      <BookingApprovalForm :bookingId="bookingId"
                           :approvalId="currentApproval.id"
                           :status="ApprovalStatus" />
    </div>
  </div>
</template>

<script>
import BookingApprovalForm from '../booking_approval/booking_approval_form.vue';
import { mapActions } from 'vuex';

export default {
  name: 'BookingAction',
  props: [
    'booking',
    'bookingApprovals',
  ],
  data() {
    return {
      ApprovalStatus: null,
    };
  },
  computed: {
    currentUserId() {
      return parseInt(
        document.getElementById('booking-container').getAttribute('data-user-id'),
        10,
      );
    },
    bookingId() {
      return document.getElementById('booking-container').getAttribute('data-booking-id');
    },
    currentApproval() {
      const userId = this.currentUserId;
      return this.bookingApprovals.find((approval) => approval.userId === userId);
    },
    statusTextClass() {
      if (this.currentApproval.status === 'accepted') {
        return 'text-success';
      }
      return 'text-danger';
    },
  },
  components: {
    BookingApprovalForm,
  },
  methods: {
    ...mapActions([
      'updateBookingStatus',
      'updateApprovalModalForm',
    ]),
    cancelBooking() {
      if (window.confirm('La réservation sera annulée définitivement, êtes vous sûr ?')) {
        this.updateBookingStatus({ bookingId: this.bookingId, status: 'canceled' });
      }
    },
    showApprovalForm(status) {
      this.ApprovalStatus = status;
      this.updateApprovalModalForm(true);
    },
  },
};
</script>
