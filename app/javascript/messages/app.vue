<template>
  <div>
    <MessageForm />
    <MessageList v-if="messageItems" />
  </div>
</template>

<script>
  import MessageForm from 'messages/components/message_form'
  import MessageList from 'messages/components/message_list'
  import { mapGetters, mapActions } from 'vuex'

  export default {
    name: 'App',
    computed: {
      ...mapGetters(['messageItems'])
    },
    components: {
      MessageForm,
      MessageList
    },
    methods: {
      ...mapActions(['getMessageItems'])
    },
    created() {
      this.getMessageItems()
    }
  }
</script>
