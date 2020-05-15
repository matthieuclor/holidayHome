<template>
  <div class="bg-light rounded position-relative card-img-top"
       :style="`height: ${height}px; width: ${height * 2}px;`">

    <i class="fas fa-home text-muted position-absolute"
        style="top: 50%; left: 50%; transform: translate(-50%, -50%);"
        :style="`font-size: ${height / 2}px;`">
    </i>
  </div>
</template>

<script>
  export default {
    name: 'VenuePhotoSkeleton',
    props: ['height']
  }
</script>
