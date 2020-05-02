<template>
  <router-link :to="{ name: 'venue', params: { id: venueItem.id } }"
               class="text-decoration-none">
    <div class="card border-0 shadow mb-3">
      <div class="row no-gutters">
        <div class="col-lg-4 p-2">
          <img v-if="venueItem.firstPhotoUrl"
               :src="venueItem.firstPhotoUrl"
               class="card-img-top">
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

              <div v-if="venueItem.withNetwork"
                   class="border rounded py-1 px-2 mr-2 mt-2">
                <i class="fas fa-wifi mr-2"></i>
                Internet
              </div>

              <div v-if="venueItem.babyBeddingsCount > 0"
                   class="border rounded py-1 px-2 mr-2 mt-2">
                  <i class="fas fa-baby mr-2"></i>
                  {{ pluralize(venueItem.babyBeddingsCount, 'Lit') + " bébé" }}
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </router-link>
</template>

<script>
  export default {
    name: 'VenueListItem',
    props: ['venueItem'],
    methods: {
      pluralize(count, string, suffix = 's') {
        return `${count} ${string}${count > 1 ? suffix : ''}`
      }
    }
  }
</script>
