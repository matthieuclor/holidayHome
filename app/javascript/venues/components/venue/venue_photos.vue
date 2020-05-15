<template>
  <div>
    <div v-if="venueItem.photos"
         id="carouselIndicators"
         class="carousel slide"
         data-ride="carousel">

      <ol class="carousel-indicators">
        <li v-for="(photo, index) in venueItem.photos"
            :key="index"
            data-target="#carouselIndicators"
            :data-slide-to="index"
            :class="{ active: index == 0 }">
        </li>
      </ol>
      <div class="carousel-inner">
        <div v-for="(photo, index) in venueItem.photos"
            :key="index"
            class="carousel-item"
            :class="{ active: index == 0 }">
          <img :src="photo.url" class="d-block rounded w-100">
        </div>
      </div>
      <a class="carousel-control-prev" href="#carouselIndicators" role="button" data-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="sr-only">Previous</span>
      </a>
      <a class="carousel-control-next" href="#carouselIndicators" role="button" data-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="sr-only">Next</span>
      </a>
    </div>

    <VenuePhotoSkeleton :size="[300, 200]" v-else />
  </div>
</template>

<script>
  import VenuePhotoSkeleton from 'venues/components/skeleton/venue_photo_skeleton'
  import { mapGetters } from 'vuex'

  export default {
    name: 'VenuePhotos',
    computed: {
      ...mapGetters(['venueItem'])
    },
    components: {
      VenuePhotoSkeleton
    }
  }
</script>
