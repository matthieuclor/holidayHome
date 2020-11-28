<template>
  <span :class="`badge badge-${badgeClass}`">
    {{statusFr}}
  </span>
</template>

<script>
export default {
  name: 'BookingStatusBadge',
  props: ['statusFr', 'status'],
  computed: {
    badgeClass() {
      switch (this.status) {
        case 'accepted':
          return 'success';
        case 'refused':
          return 'danger';
        case 'canceled':
          return 'warning';
        default:
          return 'secondary';
      }
    },
  },
};
</script>
