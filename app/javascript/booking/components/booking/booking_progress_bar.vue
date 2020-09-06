<template>
  <div ref="progressBar" class="progress" data-toggle="tooltip" :title="title">
    <div class="progress-bar"
         :class="{'bg-success': percentage >= 100}"
         role="progressbar"
         :style="`width: ${percentage}%;`"
         :aria-valuenow="percentage"
         aria-valuemin="0"
         aria-valuemax="100">
    </div>
  </div>
</template>

<script>
  export default {
    name: 'BookingProgressBar',
    props: ['percentage', 'title'],
    mounted() {
      $(this.$refs.progressBar).tooltip()
    }
  }
</script>
