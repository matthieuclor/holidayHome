<template>
  <div class="card border-0 shadow mt-2">
    <div class="card-body">
      <MessageListItem v-for="messageItem in messageItems"
                       :key="messageItem.id"
                       :messageItem="messageItem" />
    </div>
  </div>
</template>

<script>
  import MessageListItem from './message_list_item'
  import { mapGetters } from 'vuex'

  export default {
    name: 'MessageList',
    computed: {
      ...mapGetters(['messageItems'])
    },
    components: {
      MessageListItem
    }
  }
</script>
