<template>
  <div class="pt-4 px-3 w-100 content">
    <div class="d-flex flex-column flex-sm-row justify-content-sm-between align-items-center mb-2">
      <h1>Mes lieux</h1>

      <router-link :to="{ name: 'newVenue' }">
        <button @click="showSidebar"
                class="btn btn btn-outline-primary">
          <i class="fas fa-plus mr-2"></i>
          Créer un nouveau lieu
        </button>
      </router-link>
    </div>

    <div v-if="venueItems.length == 0" class="alert alert-warning">
      <i class="fas fa-exclamation-triangle"></i>
      Vous devez dans un premier temps créer votre lieu !
      <br>
      Pour ce faire cliquez sur le lien de creation.
    </div>

    <VenueListItem v-else
                   v-for="venueItem in venueItems"
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
