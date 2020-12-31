<template>
  <div class="shadow p-3 rounded mb-3">
    <div class="d-flex justify-content-between align-items-center mb-2">
      <div>
        <h4 class="m-0">{{ vehicleItem.name }}</h4>
        <p class="font-weight-lighter mb-0">
          {{ vehicleItem.vehicleType }}
        </p>
      </div>
      <div>
        <router-link :to="{
          name: 'editVehicle',
          params: { venueId: vehicleItem.venueId, id: vehicleItem.id }
        }">
          <button class="btn btn-sm btn btn-primary">
            <i class="fas fa-pen"></i>
          </button>
        </router-link>
        <button @click="destroyVehicle" class="btn btn-sm btn-danger">
          <i class="fas fa-trash"></i>
        </button>
      </div>
    </div>

    <div class="row">
      <div class="col-md-6">
        <span class="font-weight-bolder">Etat :</span>
        <span>
          {{ vehicleItem.condition }}
        </span>
      </div>
      <div class="col-md-6">
        <span class="font-weight-bolder">Taille :</span>
        <span>
          {{ vehicleItem.size }}
        </span>
      </div>
    </div>

    <div class="mt-2">
      <span class="font-weight-bolder">Commentaire :</span>
      <p class="m-0">
        {{ vehicleItem.comment }}
      </p>
    </div>
  </div>
</template>

<script>
import { mapActions } from 'vuex';

export default {
  name: 'VehicleListItem',
  props: ['vehicleItem'],
  methods: {
    ...mapActions(['destroyVehicleItem']),
    destroyVehicle() {
      if (window.confirm(`Êtes-vous sûr de vouloir supprimer ${this.vehicleItem.name} ?`)) {
        this.destroyVehicleItem(
          { venueId: this.vehicleItem.venueId, id: this.vehicleItem.id },
        );
      }
    },
  },
};
</script>
