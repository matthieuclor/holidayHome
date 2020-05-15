<template>
  <div class="bg-light w-100 h-100 position-relative card-img"
       :style="`min-width: ${width * 2}px; min-height: ${width}px;`">
    <i class="fas fa-home text-muted position-absolute"
        style="top: 50%; left: 50%; transform: translate(-50%, -50%);"
        :style="`font-size: ${width / 2}px;`">
    </i>
  </div>
</template>

<script>
  export default {
    name: 'VenuePhotoSkeleton',
    props: ['width']
  }
</script>
