<template>
  <button @click="callSetCurrentVenue"
          class="list-group-item list-group-item-action flex-fill"
          :class="{ active: currentVenue.id == venueItem.id }">
    <div class="d-flex justify-content-center align-items-center">
      <div class="mr-3">
        <img v-if="venueItem.photoUrl" :src="venueItem.photoUrl" class="rounded">
        <VenuePhotoSkeleton :width="120" v-else />
      </div>
      <div>
        <h4 class="text-nowrap mb-0">
          {{ venueItem.name }}
        </h4>
      </div>
    </div>
  </button>
</template>

<script>
import { mapActions } from 'vuex';
import VenuePhotoSkeleton from 'venues/components/skeleton/venue_photo_skeleton.vue';

export default {
  name: 'VenueListItem',
  props: ['venueItem', 'currentVenue'],
  data() {
    return { mouseover: false };
  },
  components: {
    VenuePhotoSkeleton,
  },
  methods: {
    ...mapActions(['setCurrentVenue']),
    callSetCurrentVenue() {
      this.setCurrentVenue(this.venueItem.id);
    },
  },
};
</script>
