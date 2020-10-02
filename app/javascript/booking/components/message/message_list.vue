<template>
  <div class="d-flex justify-content-center">
    <div class="col-md-8 col-lg-6">
      <div class="card mt-2">
        <div class="card-body"
             v-infinite-scroll="loadMessages"
             infinite-scroll-disabled="scrollDisabled"
             infinite-scroll-distance="10">

          <MessageListItem v-for="messageItem in messageItems"
                            :key="messageItem.id"
                            :messageItem="messageItem" />

          <div v-if="loading" class="fa-2x text-center text-secondary">
            <i class="fas fa-spinner fa-pulse"></i>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  import MessageListItem from './message_list_item'
  import infiniteScroll from 'vue-infinite-scroll'
  import { mapGetters, mapActions } from 'vuex'

  export default {
    name: 'MessageList',
    data() {
      return {
        scrollDisabled: false,
        loading: false
      }
    },
    computed: {
      ...mapGetters([
        'messageItems',
        'messagePagy'
      ]),
      bookingId() {
        return document.getElementById('booking-container').getAttribute('data-booking-id')
      }
    },
    methods: {
      ...mapActions(['getMessageItems']),
      loadMessages() {
        this.scrollDisabled = true
        this.loading = true
        const page = this.messagePagy ? this.messagePagy.next : 1

        this.getMessageItems({ bookingId: this.bookingId, page: page })
        .then(response => {
          this.scrollDisabled = response.data.messagePagy.next ? false : true
          this.loading = false
        })
      }
    },
    components: {
      MessageListItem
    },
    directives: {
      infiniteScroll
    }
  }
</script>
