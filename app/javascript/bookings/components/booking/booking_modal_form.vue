<template>
  <div class="modal" tabindex="-1" role="dialog" id="bookingModal">
    <div class="modal-dialog">
      <div v-if="bookingDateRange" class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Nouvelle réservation pour {{ currentVenue.name }}</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          <h5 class="mb-3">
            <i class="fas fa-calendar-alt mr-2"></i>
            Du {{ this.startDate }} au {{ this.endDate }}
          </h5>

          <form @submit.prevent="submitBookingModalForm">
            <div class="form-group">
              <label for="message">
                Vous avez la possibilité d'accompagner votre demande de réservation avec un message
              </label>

              <textarea v-model="message"
                        class="form-control required"
                        required="required"
                        aria-required="true"
                        id="message"
                        aria-describedby="messageHelp"
                        rows="3">
              </textarea>

              <small id="messageHelp" class="form-text text-muted">
                Vous n'avez pas besoin d'indiquer le lieu ou encore vos dates dans ce message
              </small>
            </div>

            <div class="d-flex justify-content-end">
              <button type="submit" class="btn btn-primary">Envoyer</button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import moment from 'moment';
import { mapGetters, mapActions } from 'vuex';

export default {
  name: 'BookingModalForm',
  data: () => ({ message: null }),
  computed: {
    ...mapGetters([
      'calendar',
      'currentVenue',
      'bookingModalForm',
      'bookingDateRange',
    ]),
    startDate() {
      return moment(this.bookingDateRange.start).format('DD/MM/YYYY');
    },
    endDate() {
      return moment(this.bookingDateRange.end).format('DD/MM/YYYY');
    },
  },
  methods: {
    ...mapActions([
      'createBooking',
      'updateBookingModalForm',
      'updateBookingDateRange',
    ]),
    submitBookingModalForm() {
      this.createBooking({
        ...this.bookingDateRange,
        ...this.calendar,
        message: this.message,
      }).then(() => {
        this.updateBookingDateRange(null);
        this.message = null;
      });
    },
  },
  mounted() {
    $('#bookingModal').on('hidden.bs.modal', () => {
      this.updateBookingModalForm(false);
    });
  },
  watch: {
    bookingModalForm() {
      if (this.bookingModalForm) {
        $('#bookingModal').modal('show');
      } else {
        $('#bookingModal').modal('hide');
      }
    },
  },
};
</script>
