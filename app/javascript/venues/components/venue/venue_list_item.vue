<template>
  <router-link :to="{ name: 'venue', params: { id: venueItem.id } }">
    <div @click="showSidebar" class="card mb-3" :class="shadowType(venueItem.id)">
      <div class="row no-gutters">
        <div class="col-lg-4 p-2">
          <img v-if="venueItem.firstPhotoUrl"
               :src="venueItem.firstPhotoUrl"
               class="card-img-top">
          <VenuePhotoSkeleton :width="100" v-else />
        </div>
        <div class="col-lg-8 p-2">
          <div class="card-body p-0">
            <h4 class="card-title text-dark mb-0">
              {{ venueItem.name }}
            </h4>

            <p class="card-text font-weight-lighter text-dark mb-0">
              {{ venueItem.address }}
            </p>

            <div class="d-flex flex-wrap text-muted">
              <div class="border rounded py-1 px-2 mr-2 mt-2">
                <i class="fas fa-users mr-2"></i>
                {{ pluralize(venueItem.beddingsCount, 'Place') }}
              </div>

              <div class="border rounded py-1 px-2 mr-2 mt-2">
                <i class="fas fa-bed mr-2"></i>
                {{ pluralize(venueItem.bedroomsCount, 'Chambre') }}
              </div>

              <div class="border rounded py-1 px-2 mr-2 mt-2">
                <i class="fas fa-shower mr-2"></i>
                {{ pluralize(venueItem.bathroomsCount, 'Salle') + " de bain" }}
              </div>

              <div v-if="venueItem.babyBedsCount > 0"
                   class="border rounded py-1 px-2 mr-2 mt-2">
                <i class="fas fa-baby mr-2"></i>
                {{ pluralize(venueItem.babyBedsCount, 'Lit bébé') }}
              </div>

              <div v-if="venueItem.withNetwork"
                   class="border rounded py-1 px-2 mr-2 mt-2">
                <i class="fas fa-wifi mr-2"></i>
                Internet
              </div>

              <div v-if="venueItem.withWashingMachine"
                   class="border rounded py-1 px-2 mr-2 mt-2">
                <i class="fas fa-tshirt"></i>
                Lave-linge
              </div>

              <div v-if="venueItem.withTumbleDryer"
                   class="border rounded py-1 px-2 mr-2 mt-2">
                <i class="far fa-tshirt"></i>
                Sèche-linge
              </div>

              <div v-if="venueItem.withDishwasher"
                   class="border rounded py-1 px-2 mr-2 mt-2">
                <i class="fas fa-utensils mr-2"></i>
                Lave-vaisselle
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </router-link>
</template>

<script>
import textMixin from 'shared/mixins/text_mixin';
import VenuePhotoSkeleton from 'venues/components/skeleton/venue_photo_skeleton';
import { mapActions } from 'vuex';

export default {
  name: 'VenueListItem',
  props: ['venueItem'],
  mixins: [textMixin],
  components: {
    VenuePhotoSkeleton,
  },
  methods: {
    ...mapActions(['showSidebar']),
    shadowType(id) {
      return this.$route.params.id === id ? 'shadow' : 'shadow-sm';
    },
  },
};
</script>
