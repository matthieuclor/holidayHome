<template>
  <div>
    <div class="form-group string required venue_name">
      <label for="venue_address" class="string required">
        Adresse <abbr title="obligatoire">*</abbr>
      </label>
      <input ref="inputSearch"
             :value="newVenueItem.address"
             placeholder="12 Rue de Bellecote"
             type="text"
             name="venue[address]"
             id="venue_address"
             class="form-control string required">
    </div>

    <div class="form-group hidden venue_city">
      <input type="hidden"
             :value="newVenueItem.city"
             name="venue[city]"
             id="venue_city"
             class="form-control hidden">
    </div>

    <div class="form-group hidden venue_postcode">
      <input type="hidden"
             :value="newVenueItem.postcode"
             name="venue[postcode]"
             id="venue_postcode"
             class="form-control hidden">
    </div>

    <div class="form-group hidden venue_country">
      <input type="hidden"
             :value="newVenueItem.country"
             name="venue[country]"
             id="venue_country"
             class="form-control hidden">
    </div>

    <div class="form-group hidden venue_country_code">
      <input type="hidden"
             :value="newVenueItem.countryCode"
             name="venue[country_code]"
             id="venue_country_code"
             class="form-control hidden">
    </div>

    <div class="form-group hidden venue_administrative">
      <input type="hidden"
             :value="newVenueItem.administrative"
             name="venue[administrative]"
             id="venue_administrative"
             class="form-control hidden">
    </div>

    <div class="form-group hidden venue_county">
      <input type="hidden"
             :value="newVenueItem.county"
             name="venue[county]"
             id="venue_county"
             class="form-control hidden">
    </div>

    <div class="form-group hidden venue_lat">
      <input type="hidden"
             :value="newVenueItem.lat"
             name="venue[lat]"
             id="venue_lat"
             class="form-control hidden">
    </div>

    <div class="form-group hidden venue_lng">
      <input type="hidden"
             :value="newVenueItem.lng"
             name="venue[lng]"
             id="venue_lng"
             class="form-control hidden">
    </div>
  </div>
</template>

<script>
  import { mapGetters } from 'vuex'
  import places from 'places.js'

  export default {
    name: 'VenuePlaces',
    data() {
      return {
        place: null,
        language: 'fr',
        options: {
          appId: 'pl75UUU9N2VV',
          apiKey: '9a55decbc8fd5c78a1d571f4143fef56',
          container: null
        }
      }
    },
    computed: {
      ...mapGetters([
        'newVenueItem'
      ]),
    },
    mounted() {
      this.$nextTick(function () {
        this.options.container = this.$refs.inputSearch
        this.place = places(this.options).configure(this.language)
        this.place.on('change', event => {
          this.newVenueItem.address = event.suggestion.value
          this.newVenueItem.city = event.suggestion.name
          this.newVenueItem.postcode = event.suggestion.postcode
          this.newVenueItem.country = event.suggestion.country
          this.newVenueItem.countryCode = event.suggestion.countryCode
          this.newVenueItem.administrative = event.suggestion.administrative
          this.newVenueItem.county = event.suggestion.county
          this.newVenueItem.lat = event.suggestion.latlng.lat
          this.newVenueItem.lng = event.suggestion.latlng.lng
        })
      })
    }
  }
</script>
