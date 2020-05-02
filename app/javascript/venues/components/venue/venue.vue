<template>
  <div v-if="venueItem">
    <div class="d-flex justify-content-between align-items-center">
      <h1>{{ venueItem.name }}</h1>

      <button class="btn btn-primary">
        <i class="fas fa-pen mr-2"></i>
        Editer
      </button>
    </div>

    <div v-if="venueItem.photos.length > 0"
        id="carouselIndicators"
        class="carousel slide"
        data-ride="carousel">

      <ol class="carousel-indicators">
        <li v-for="(photo, index) in venueItem.photos"
            :key="index"
            data-target="#carouselIndicators"
            :data-slide-to="index"
            :class="{ active: index == 0 }">
        </li>
      </ol>
      <div class="carousel-inner">
        <div v-for="(photo, index) in venueItem.photos"
            :key="index"
            class="carousel-item"
            :class="{ active: index == 0 }">
          <img :src="photo.url" class="d-block rounded w-100">
        </div>
      </div>
      <a class="carousel-control-prev" href="#carouselIndicators" role="button" data-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="sr-only">Previous</span>
      </a>
      <a class="carousel-control-next" href="#carouselIndicators" role="button" data-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="sr-only">Next</span>
      </a>
    </div>

    <p class="text-muted mb-2">
      {{ venueItem.address }}
    </p>

    <p class="font-weight-bold">
      {{ pluralize(venueItem.beddingsCount, "Place") }}
      <span>&bull;</span>
      {{ pluralize(venueItem.bedroomsCount, "Chambre") }}
      <span>&bull;</span>
      {{ pluralize(venueItem.bathroomsCount, "Salle") + " de bain" }}

      <span v-if="venueItem.withNetwork">
        <span>&bull;</span>
        Internet
      </span>

      <span v-if="venueItem.babyBeddingsCount > 0">
        <span>&bull;</span>
        {{ pluralize(venueItem.babyBeddingsCount, "Lit") + " bébé" }}
      </span>
    </p>

    <div v-if="venueItem.mapUrl">
      <hr class="my-4">
      <h4>Emplacement :</h4>
      <img :src="venueItem.mapUrl" class="rounded">
    </div>

    <Bedrooms v-if="venueItem.bedrooms" :bedrooms="venueItem.bedrooms" />

    <Bathrooms v-if="venueItem.bathrooms" :bathrooms="venueItem.bathrooms" />

    <Keys v-if="venueItem.keys" :keys="venueItem.keys" />

    <Networks v-if="venueItem.networks" :networks="venueItem.networks" />

    <DigitalCodes v-if="venueItem.digitalCodes" :digitalCodes="venueItem.digitalCodes" />

    <HomeServices v-if="venueItem.homeServices" :homeServices="venueItem.homeServices" />

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

    <div class="d-flex justify-content-end mt-4">
      <button class="btn btn-danger">
        <i class="fas fa-trash mr-2"></i>
        Supprimer {{ venueItem.name }}
      </button>
    </div>
  </div>
</template>

<script>
  import Bedrooms from 'venues/components/bedroom/bedrooms'
  import Bathrooms from 'venues/components/bathroom/bathrooms'
  import Keys from 'venues/components/key/keys'
  import Networks from 'venues/components/network/networks'
  import DigitalCodes from 'venues/components/digital_code/digital_codes'
  import HomeServices from 'venues/components/home_service/home_services'
  import { mapGetters, mapActions } from 'vuex'

  export default {
    name: 'Venue',
    props: ['id'],
    components: {
      Bedrooms,
      Bathrooms,
      Keys,
      Networks,
      DigitalCodes,
      HomeServices
    },
    computed: {
      ...mapGetters([
        'venueItem'
      ]),
    },
    methods: {
      ...mapActions([
        'getVenueItem'
      ]),
      pluralize(count, string, suffix = 's') {
        return `${count} ${string}${count > 1 ? suffix : ''}`
      }
    },
    watch: {
      id: {
        handler() { this.getVenueItem(this.id) },
        immediate: true
      }
    }
  }
</script>
