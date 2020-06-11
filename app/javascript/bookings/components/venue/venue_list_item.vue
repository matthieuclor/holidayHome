<template>
  <div class="my-2 mr-4 rounded"
       :class="shadowType(venueItem.id)"
       style="cursor: pointer;"
       @click="callSetCurrentVenue"
       @mouseover="mouseover = true"
       @mouseleave="mouseover = false">

    <div class="d-flex">
      <div class="p-2">
        <img v-if="venueItem.photoUrl" :src="venueItem.photoUrl" class="rounded">
        <VenuePhotoSkeleton :width="100" v-else />
      </div>
      <div class="p-2">
        <h4 class="text-nowrap mb-0 pr-2">
          {{ venueItem.name }}
        </h4>
      </div>
    </div>
  </div>
</template>

<script>
  import { mapActions } from 'vuex'
  import VenuePhotoSkeleton from 'venues/components/skeleton/venue_photo_skeleton'

  export default {
    name: 'VenueListItem',
    props: ['venueItem', 'currentVenue'],
    data() {
      return { mouseover: false }
    },
    components: {
      VenuePhotoSkeleton
    },
    methods: {
      ...mapActions(['setCurrentVenue']),
      shadowType(id) {
        return this.currentVenue.id == id || this.mouseover ? 'shadow' : 'shadow-sm'
      },
      callSetCurrentVenue() {
        this.setCurrentVenue(this.venueItem.id)
      }
    }
  }
</script>
