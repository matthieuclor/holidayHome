<template>
  <div>
    <BookingItem />

    <MessageForm />

    <MessageList />

    <div id="v-toast-container">
      <FlashMessage v-for="(flash, index) in flashes" :key="index" :flash="flash" />
    </div>
  </div>
</template>

<script>
import BookingItem from './components/booking/booking_item.vue';
import MessageForm from './components/message/message_form.vue';
import MessageList from './components/message/message_list.vue';
import FlashMessage from 'shared/components/flash/flash_message';
import consumer from 'channels/consumer';
import { mapGetters, mapActions } from 'vuex';

export default {
  name: 'App',
  data: () => ({ subscription: null }),
  computed: {
    ...mapGetters(['flashes']),
    bookingId() {
      return document.getElementById('booking-container').getAttribute('data-booking-id');
    },
    bookingStatus() {
      return document.getElementById('booking-container').getAttribute('data-booking-status');
    },
  },
  methods: {
    ...mapActions([
      'addMessageItem',
      'updateApprovalItem',
      'updateBookingCurrentUsers',
    ]),
  },
  components: {
    BookingItem,
    MessageForm,
    MessageList,
    FlashMessage,
  },
  mounted() {
    const { addMessageItem } = this;
    const { updateApprovalItem } = this;
    const { updateBookingCurrentUsers } = this;

    if (this.bookingStatus === 'pending') {
      this.subscription = consumer.subscriptions.create(
        { channel: 'BookingChannel', booking_id: this.bookingId }, {
          received(data) {
            if (data.message) addMessageItem(JSON.parse(data.message));
            if (data.bookingApproval) updateApprovalItem(JSON.parse(data.bookingApproval));
            if (data.currentUsers) updateBookingCurrentUsers(data.currentUsers);
          },
        },
      );
    }
  },
  destroyed() {
    if (this.subscription) consumer.subscriptions.remove(this.subscription);
  },
};
</script>
