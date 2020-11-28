<template>
  <div :class="`d-flex ${justifyClass}`">
    <div :class="`rounded py-2 px-3 mb-3 w-75 ${bgClass} ${textClass}`">
      <div class="d-flex flex-row align-items-center justify-content-between">
        <a :href="`/user_account/users/${messageItem.userId}`"
           :class="`font-weight-bold ${textClass}`"
           data-remote="true">
          {{ messageItem.userName }}
        </a>
        <span v-if="messageItem.approvalStatus"
              class="badge"
              :class="bgStatusClass">
          {{ messageItem.approvalStatusTitle }}
        </span>
      </div>

      <div class="my-1 vue-html" v-html="messageItem.content">
      </div>

      <div class="d-flex flex-row align-items-center">
        <span class="ml-auto font-weight-lighter">
          {{ messageItem.createdAt }}
        </span>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'MessageListItem',
  props: ['messageItem'],
  computed: {
    userId() {
      return parseInt(
        document.getElementById('booking-container').getAttribute('data-user-id'),
        10,
      );
    },
    fromCurrentUser() {
      return this.messageItem.userId === this.userId;
    },
    justifyClass() {
      return this.fromCurrentUser ? 'justify-content-start' : 'justify-content-end';
    },
    bgClass() {
      return this.fromCurrentUser ? 'bg-primary' : 'bg-light';
    },
    textClass() {
      return this.fromCurrentUser ? 'text-white' : 'text-dark';
    },
    bgStatusClass() {
      if (this.messageItem.approvalStatus === 'accepted') {
        return 'badge-success';
      }
      return 'badge-danger';
    },
  },
};
</script>
