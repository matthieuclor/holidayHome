<template>
  <div class="d-flex justify-content-center">
    <div class="col-md-8 col-lg-6">
      <div class="card border-0 shadow mt-2">
        <div class="card-body">
          <MessageListItem v-for="messageItem in messageItems"
                          :key="messageItem.id"
                          :messageItem="messageItem" />
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  import MessageListItem from './message_list_item'
  import { mapGetters, mapActions } from 'vuex'

  export default {
    name: 'MessageList',
    computed: {
      ...mapGetters(['messageItems']),
      bookingId() {
        return document.getElementById('booking-container').getAttribute('data-booking-id')
      }
    },
    methods: {
      ...mapActions(['getMessageItems'])
    },
    components: {
      MessageListItem
    },
    created() {
      this.getMessageItems(this.bookingId)
    }
  }
</script>
