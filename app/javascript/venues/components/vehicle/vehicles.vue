<template>
  <div>
    <div v-if="vehicleVenueItem">
      <div class="d-flex justify-content-between align-items-center mb-2">
        <h1 class="m-0">{{ vehicleVenueItem.name }}</h1>

        <button @click="hideSidebar"
                type="button"
                class="btn btn-link text-muted ml-2">

          <i class="far fa-times fa-2x"></i>
        </button>
      </div>
      <div class="d-flex justify-content-between align-items-center my-3">
        <h3 class="m-0">Mes Vehicules</h3>

        <router-link :to="{ name: 'newVehicle', params: { venueId: vehicleVenueItem.id } }">
          <button class="btn btn-sm btn btn-outline-primary">
            <i class="fas fa-plus mr-2"></i>
            Créer un nouveau vehicule
          </button>
        </router-link>
      </div>

      <p v-if="vehicleItems.length === 0" class="text-muted text-center mt-3">
        Vous n'avez pas de véhicule
      </p>
      <VehicleListItem v-else
                       v-for="vehicleItem in vehicleItems"
                       :key="vehicleItem.id"
                       :vehicleItem="vehicleItem" />
    </div>
    <div v-else >
      <VenueVehiclesSkeleton />
    </div>
  </div>
</template>

<script>
import VehicleListItem from 'venues/components/vehicle/vehicle_list_item';
import VenueVehiclesSkeleton from 'venues/components/skeleton/venue_vehicles_skeleton';
import { mapGetters, mapActions } from 'vuex';

export default {
  name: 'Vehicles',
  props: ['venueId'],
  components: {
    VehicleListItem,
    VenueVehiclesSkeleton,
  },
  computed: {
    ...mapGetters([
      'sidebar',
      'vehicleVenueItem',
      'vehicleItems',
    ]),
  },
  methods: {
    ...mapActions([
      'showSidebar',
      'hideSidebar',
      'getVehicleItems',
    ]),
  },
  watch: {
    venueId: {
      handler() {
        this.getVehicleItems(this.venueId);
        if (!this.sidebar) this.showSidebar();
      },
      immediate: true,
    },
  },
};
</script>
