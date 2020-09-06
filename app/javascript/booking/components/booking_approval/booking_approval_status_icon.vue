<template>
  <i ref="icon"
     class="far"
     :class="[icon, color]"
     data-toggle="tooltip"
     :title="statusTitle"></i>
</template>

<script>
  export default {
    name: 'BookingApprovalStatusIcon',
    props: ['status', 'statusTitle'],
    computed: {
      icon() {
        switch (this.status) {
          case 'accepted':
            return 'fa-check-circle'
          case 'refused':
            return 'fa-times-circle'
          case 'out_of_time':
            return 'fa-clock'
          default:
            return 'fa-circle'
        }
      },
      color() {
        switch (this.status) {
          case 'accepted':
            return 'text-success'
          case 'refused':
            return 'text-danger'
          case 'out_of_time':
            return 'text-warning'
          default:
            return 'text-secondary'
        }
      }
    },
    mounted() {
      $(this.$refs.icon).tooltip()
    },
    beforeUpdate() {
      $(this.$refs.icon).tooltip('dispose')
    },
    updated() {
      $(this.$refs.icon).tooltip()
    }
  }
</script>
