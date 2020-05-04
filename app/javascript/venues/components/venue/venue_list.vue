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

    <VenueListItem v-for="venueItem in venueItems"
                   :key="venueItem.id"
                   :venueItem="venueItem" />
  </div>
</template>

<script>
  import VenueListItem from 'venues/components/venue/venue_list_item'
  import { mapGetters, mapActions } from 'vuex'

  export default {
    name: 'VenueList',
    components: {
      VenueListItem
    },
    computed: {
      ...mapGetters([
        'venueItems'
      ]),
    },
    methods: {
      ...mapActions([
        'getVenueItems'
      ])
    },
    created() {
      this.getVenueItems()
    }
  }
</script>
