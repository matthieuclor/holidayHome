<template>
  <div class="h-100">
    <img v-if="photoUrl"
         class="rounded img-fluid w-100"
         :src="photoUrl">
    <span v-else
          class="d-block bg-light rounded img-fluid position-relative h-100">

      <span class="text-muted position-absolute" :style="styleIcon">
        <i class="fas fa-home"></i>
      </span>
    </span>
  </div>
</template>

<script>
export default {
  name: 'VenuePhoto',
  props: ['photoUrl', 'format'],
  data() {
    return {
      styleIcon: {
        top: '50%',
        left: '50%',
        transform: 'translate(-50%, -50%)',
        fontSize: `${this.format[1] / 2}px`,
      },
    };
  },
};
</script>
