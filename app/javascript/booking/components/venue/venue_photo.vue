<template>
  <div>
    <img v-if="photoUrl"
         class="rounded img-fluid w-100"
         :src="photoUrl">
    <span v-else
          class="d-block bg-light rounded img-fluid position-relative"
          :style="`width: ${format[0]}px; height: ${format[1]}px;`">

      <span class="text-muted position-absolute"
            :style="`top: 50%; left: 50%; transform: translate(-50%, -50%); font-size: ${format[1]/2}px;`">

        <i class="fas fa-home"></i>
      </span>
    </span>
  </div>
</template>

<script>
  export default {
    name: 'VenuePhoto',
    props: ['photoUrl', 'format']
  }
</script>
