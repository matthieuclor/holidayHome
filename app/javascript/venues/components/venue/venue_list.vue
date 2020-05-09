<template>
  <div>
    <div class="d-flex justify-content-between align-items-center">
      <h1>Mes lieux</h1>
      <router-link :to="{ name: 'newVenue' }">
        <button class="btn btn btn-outline-primary">
          <i class="fas fa-plus mr-2"></i>
          Créer un nouveau lieu
        </button>
      </router-link>
    </div>

    <VenueListSkeleton v-if="venueItems.length == 0" />

    <VenueListItem v-for="venueItem in venueItems"
                   :key="venueItem.id"
                   :venueItem="venueItem"
                   v-else />

    <venuePagy />
  </div>
</template>

<script>
  import VenueListSkeleton from 'venues/components/skeleton/venue_list_skeleton'
  import VenueListItem from 'venues/components/venue/venue_list_item'
  import venuePagy from 'venues/components/venue/venue_pagy'
  import { mapGetters, mapActions } from 'vuex'

  export default {
    name: 'VenueList',
    components: {
      VenueListSkeleton,
      VenueListItem,
      venuePagy
    },
    computed: {
      ...mapGetters(['venueItems']),
    },
    methods: {
      ...mapActions(['getVenueItems'])
    },
    created() {
      this.getVenueItems()
    }
  }
</script>
