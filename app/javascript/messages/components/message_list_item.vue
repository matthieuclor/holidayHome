<template>
  <div :class="`d-flex ${justifyClass}`">
    <div :class="`rounded py-2 px-3 mb-3 w-75 ${bgClass} ${textClass}`">
      <div class="d-flex flex-row align-items-center justify-content-between">
        <span :class="`font-weight-bold ${textClass}`">
          {{messageItem.userName}}
        </span>
      </div>

      <div class="my-1">
        {{messageItem.content}}
      </div>

      <div class="d-flex flex-row align-items-center">
        <span class="ml-auto font-weight-lighter">
          {{messageItem.createdAt}}
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
        return document.getElementById('messages-container')
          .getAttribute('data-user-id')
      },
      fromCurrentUser() {
        return this.messageItem.userId == this.userId
      },
      justifyClass() {
        return this.fromCurrentUser ? 'justify-content-start' : 'justify-content-end'
      },
      bgClass() {
        return this.fromCurrentUser ? 'bg-primary' : 'bg-light'
      },
      textClass() {
        return this.fromCurrentUser ? 'text-white' : 'text-black'
      }
    }
  }
</script>
