<template>
  <div class="card border-0 shadow-sm m-2" :class="{ shadow: active }">
    <div class="row no-gutters">
      <div class="p-2">
        <img v-if="venueItem.photoUrl"
             :src="venueItem.photoUrl"
             class="rounded">

        <VenuePhotoSkeleton :height="100" v-else />
      </div>
      <div class="p-2">
        <div class="card-body p-0">
          <h4 class="card-title text-dark mb-0">
            {{ venueItem.name }}
          </h4>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  import VenuePhotoSkeleton from 'venues/components/skeleton/venue_photo_skeleton'

  export default {
    name: 'VenueListItem',
    props: ['venueItem', 'active'],
    components: {
      VenuePhotoSkeleton
    }
  }
</script>
