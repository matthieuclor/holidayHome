<template>
  <div class="m-2 rounded"
       :class="shadowType(venueItem.id)"
       style="cursor: pointer;"
       @click="callSetCurrentVenueId"
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
    props: ['venueItem', 'currentVenueId'],
    data() {
      return { mouseover: false }
    },
    components: {
      VenuePhotoSkeleton
    },
    methods: {
      ...mapActions([
        'setCurrentVenueId'
      ]),
      shadowType(id) {
        return this.currentVenueId == id || this.mouseover ? 'shadow' : 'shadow-sm'
      },
      callSetCurrentVenueId() {
        this.setCurrentVenueId(this.venueItem.id)
        .then(response => {
          console.log('success', response)
        }).catch(error => {
          console.log('error', error)
        })
      }
    }
  }
</script>
