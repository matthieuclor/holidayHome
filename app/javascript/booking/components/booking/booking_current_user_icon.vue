<template>
  <i ref="icon"
     class="fa-dot-circle"
     :class="[icon, color]"
     data-toggle="tooltip"
     :title="statusTitle"></i>
</template>

<script>
import { mapGetters } from 'vuex';

export default {
  name: 'BookingCurrentUserIcon',
  props: ['userId'],
  computed: {
    ...mapGetters(['bookingCurrentUsers']),
    isConnected() {
      return this.bookingCurrentUsers.includes(`${this.userId}`);
    },
    icon() {
      return this.isConnected ? 'fas' : 'far';
    },
    color() {
      return this.isConnected ? 'text-primary' : 'text-secondary';
    },
    statusTitle() {
      return this.isConnected ? 'En ligne' : 'Hors ligne';
    },
  },
  mounted() {
    $(this.$refs.icon).tooltip();
  },
  beforeUpdate() {
    $(this.$refs.icon).tooltip('dispose');
  },
  updated() {
    $(this.$refs.icon).tooltip();
  },
};
</script>
