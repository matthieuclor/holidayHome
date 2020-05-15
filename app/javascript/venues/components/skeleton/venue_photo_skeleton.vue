<template>
  <div class="bg-light rounded position-relative card-img-top"
       :style="`height: ${size[1]}px; width: ${size[0]}px;`">

    <i class="fas fa-home text-muted position-absolute"
        style="top: 50%; left: 50%; transform: translate(-50%, -50%);"
        :style="`font-size: ${size[1] / 2}px;`">
    </i>
  </div>
</template>

<script>
  export default {
    name: 'VenuePhotoSkeleton',
    props: ['size']
  }
</script>
