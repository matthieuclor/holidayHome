<template>
  <div>
    <div v-if="venueItem">
      <div class="d-flex justify-content-between align-items-center mb-2">
        <h1 class="m-0 text-truncate">{{ venueItem.name }}</h1>

        <div class="d-flex flex-row align-items-center">
          <router-link v-if="venueItem.isEditable"
                       :to="{ name: 'editVenue', params: { id: venueItem.id } }">

            <button class="btn btn-primary text-nowrap">
              <i class="fas fa-pen mr-2"></i>
              Editer
            </button>
          </router-link>

          <button @click="hideSidebar"
                  type="button"
                  class="btn btn-link text-muted ml-2">

            <i class="far fa-times fa-2x"></i>
          </button>
        </div>
      </div>

      <VenuePhotos />

      <p class="text-muted mb-2">
        {{ venueItem.address }}
      </p>

      <p class="font-weight-bold mb-0">
        {{ pluralize(venueItem.beddingsCount, "Place") }}
        <span>&bull;</span>
        {{ pluralize(venueItem.bedroomsCount, "Chambre") }}
        <span>&bull;</span>
        {{ pluralize(venueItem.bathroomsCount, "Salle") + " de bain" }}

        <span v-if="venueItem.babyBedsCount > 0">
          <span>&bull;</span>
          {{ pluralize(venueItem.babyBedsCount, 'Lit bébé') }}
        </span>
      </p>

      <p class="text-muted">
        <span v-for="(accessory, index) in Accessories" :key="index">
          <span v-if="index !== 0">&bull;</span>
          {{ accessory }}
        </span>
      </p>

      <router-link :to="{ name: 'vehicles', params: { venueId: venueItem.id } }">
        <button class="btn btn-outline-secondary py-1 px-2">
          <i class="fas fa-bicycle mr-2"></i>
          {{ pluralize(venueItem.vehiclesCount, 'Véhicule') }}
        </button>
      </router-link>

      <div v-if="venueItem.mapUrl">
        <hr class="my-4">
        <h4>Emplacement :</h4>
        <a :href="venueItem.mapLink" target="_blank">
          <img :src="venueItem.mapUrl" class="rounded">
        </a>
      </div>

      <VenueBedroom />

      <VenueSofaBeds />

      <VenueBathroom />

      <KeyList v-if="venueItem.keys" :keys="venueItem.keys" />

      <NetworkList v-if="venueItem.networks" :networks="venueItem.networks" />

      <DigitalCodeList v-if="venueItem.digitalCodes"
                       :digitalCodes="venueItem.digitalCodes" />

      <HomeServiceList v-if="venueItem.homeServices"
                       :homeServices="venueItem.homeServices" />

      <div v-if="venueItem.comment">
        <hr class="my-4">

        <h4 class="mb-3">
          Commentaire :
        </h4>

        <div class="shadow p-3 rounded mb-3">
          <p class="m-0">
            {{ venueItem.comment }}
          </p>
        </div>
      </div>

      <div v-if="venueItem.isEditable" class="d-flex justify-content-end mt-4">
        <button @click="destroyVenue" class="btn btn-danger">
          <i class="fas fa-trash mr-2"></i>
          Supprimer {{ venueItem.name }}
        </button>
      </div>

      <div class='tr-footer'></div>
    </div>
    <div v-else >
      <VenueSkeleton />
    </div>
  </div>
</template>

<script>
import VenuePhotos from 'venues/components/venue/venue_photos';
import VenueSkeleton from 'venues/components/skeleton/venue_skeleton';
import VenueBedroom from 'venues/components/venue/venue_bedroom';
import VenueSofaBeds from 'venues/components/venue/venue_sofa_beds';
import VenueBathroom from 'venues/components/venue/venue_bathroom';
import KeyList from 'venues/components/key/key_list';
import NetworkList from 'venues/components/network/network_list';
import DigitalCodeList from 'venues/components/digital_code/digital_code_list';
import HomeServiceList from 'venues/components/home_service/home_service_list';
import textMixin from 'shared/mixins/text_mixin';
import { mapGetters, mapActions } from 'vuex';

export default {
  name: 'Venue',
  props: ['id'],
  components: {
    VenueSkeleton,
    VenuePhotos,
    VenueBedroom,
    VenueSofaBeds,
    VenueBathroom,
    KeyList,
    NetworkList,
    DigitalCodeList,
    HomeServiceList,
  },
  computed: {
    ...mapGetters([
      'venueItem',
      'sidebar',
    ]),
    Accessories() {
      const accessories = [];
      if (this.venueItem.withWashingMachine) accessories.push('Lave-linge');
      if (this.venueItem.withTumbleDryer) accessories.push('Sèche-linge');
      if (this.venueItem.withDishwasher) accessories.push('Lave-vaisselle');
      if (this.venueItem.withNetwork) accessories.push('Internet');

      return accessories;
    },
  },
  mixins: [textMixin],
  methods: {
    ...mapActions([
      'showSidebar',
      'getVenueItem',
      'destroyVenueItem',
      'hideSidebar',
    ]),
    destroyVenue() {
      if (window.confirm(`Êtes-vous sûr de vouloir supprimer ${this.venueItem.name} ?`)) {
        this.destroyVenueItem(this.id)
          .then(() => this.$router.push({ name: 'venues' }))
          .catch(() => null);
      }
    },
  },
  watch: {
    id: {
      handler() {
        this.getVenueItem(this.id);
        if (!this.sidebar) this.showSidebar();
      },
      immediate: true,
    },
  },
};
</script>
