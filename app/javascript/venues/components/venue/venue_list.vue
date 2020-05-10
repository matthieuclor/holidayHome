<template>
  <div>
    <div class="d-flex justify-content-between align-items-center">
      <h1>Mes lieux</h1>
      <router-link :to="{ name: 'newVenue' }">
        <button @click="showSidebar"
                class="btn btn btn-outline-primary">
          <i class="fas fa-plus mr-2"></i>
          Créer un nouveau lieu
        </button>
      </router-link>
    </div>

    <VenueListItem v-for="venueItem in venueItems"
                   :key="venueItem.id"
                   :venueItem="venueItem" />

    <venuePagy />
  </div>
</template>

<script>
  import VenueListItem from 'venues/components/venue/venue_list_item'
  import venuePagy from 'venues/components/venue/venue_pagy'
  import { mapGetters, mapActions } from 'vuex'

  export default {
    name: 'VenueList',
    components: {
      VenueListItem,
      venuePagy
    },
    computed: {
      ...mapGetters(['venueItems']),
    },
    methods: {
      ...mapActions([
        'getVenueItems',
        'showSidebar'
      ])
    },
    created() {
      this.getVenueItems()
    }
  }
</script>
