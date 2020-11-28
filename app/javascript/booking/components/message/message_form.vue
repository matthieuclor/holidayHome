<template>
  <div v-if="bookingItem && bookingItem.status == 'pending'"
       class="d-flex justify-content-center">

    <div class="col-md-8 col-lg-6">
      <div class="card mt-2">
        <div class="card-body">
          <form @submit.prevent="submitForm">
            <div class="form-group">
              <textarea v-model="message"
                        class="form-control required"
                        :class="{ 'is-invalid': showMessageFormError }"
                        rows="3"
                        required="required"
                        aria-required="true"
                        aria-describedby="messageHelp"
                        placeholder="Ecrivez un message au sujet de cette réservation">
              </textarea>

              <small id="messageHelp" class="form-text text-muted">
                {{charCount}}/{{contentMax}} caractères.
              </small>

              <small v-if="showMessageFormError" class="text-danger">
                {{messageFormError}}
              </small>
            </div>

            <button type="submit" class="btn btn-sm btn-success float-right mt-n3">Envoyer</button>
          </form>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { mapGetters, mapActions } from 'vuex';

export default {
  name: 'MessageForm',
  data() {
    return {
      message: '',
      showMessageFormError: false,
      messageFormError: '',
    };
  },
  computed: {
    ...mapGetters(['bookingItem']),
    charCount() {
      return this.message.length;
    },
    contentMax() {
      return document.getElementById('booking-container').getAttribute('data-content-max');
    },
    bookingId() {
      return document.getElementById('booking-container').getAttribute('data-booking-id');
    },
  },
  methods: {
    ...mapActions(['createMessage']),
    submitForm() {
      if (this.charCount > 0) {
        this.createMessage({ bookingId: this.bookingId, message: this.message })
          .then(() => {
            this.showMessageFormError = false;
            this.messageFormError = '';
            this.message = '';
          }).catch((error) => {
            this.messageFormError = error.response.data.error;
            this.showMessageFormError = true;
          });
      }
    },
  },
  watch: {
    message() {
      if (this.charCount > this.contentMax) {
        this.message = this.message.substring(0, this.contentMax);
      }
    },
  },
};
</script>
